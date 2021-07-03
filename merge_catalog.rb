#!/usr/bin/env ruby

require 'csv'
require 'set'

###############
# Data Models #
###############

Catalog = Struct.new(:items) do
  def add(item)
    items.append(item)
  end
end
CatalogItem = Struct.new(:sku, :description, :source)
Barcode = Struct.new(:supplier_id, :sku, :id)
Supplier = Struct.new(:id, :name)

###########
# Methods #
###########

# Reads the CSV content from a given file name
def read_csv_from_file_named(file_name)
  # Drop the first row as it contains the legend
  CSV.read("./input/#{file_name}.csv").drop(1)
end

# Sorts a given catalog based on its description and source to be more human discoverable
def sort(catalog)
  catalog.to_a.sort { |a,b| [a.description, a.source] <=> [b.description, b.source] }
end

# Go through each items in a catalog and add it to the new catalog `to_catalog` if needed
def extract_items(from_catalog, from_barcodes, merged_catalog, merged_barcodes)
  from_catalog.items.each do |catalog_item|
    # Select each barcodes that corresponds to the item's SKU we are inspecting
    barcodes = from_barcodes.select { |e| e.sku == catalog_item.sku }

    # Find a matching barcode from the new catalog
    found_match = false
    merged_barcodes.each do |barcode_a|
      if barcodes.map { |e| e.id }.include? barcode_a.id
        found_match = true
        break
      end
    end

    # If a match is found, it means we already have the item
    # So we skip adding it to the merged catalog
    unless found_match
      merged_catalog.add(catalog_item)
    end
  end

  # Add barcodes to the merged barcodes list so we keep track of all barcodes
  # as we move forward
  merged_barcodes.append(from_barcodes)
end

# Writes the given catalog to a given output file name
def write_catalog_to_output_file(file_name, catalog)
  output_file = File.open("./output/#{file_name}.csv", "w")
  output_file.puts "SKU,Description,Source"
  sort(catalog.items).each { |e| output_file.puts "#{e.sku},#{e.description},#{e.source}" }
  output_file.close
end

# Tests the scripts output
def test(catalog)
  sorted_script_catalog = sort(catalog.items)
  result_output_catalog = CSV.read("./output/result_output.csv")
    .drop(1)
    .map { |e| CatalogItem.new(e[0], e[1], e[2]) }
  result_output_sorted_catalog = sort(result_output_catalog)

  if sorted_script_catalog == result_output_sorted_catalog
    puts "###############"
    puts "# Test PASSED #"
    puts "###############"
    true
  else
    puts "###############"
    puts "# Test FAILED #"
    puts "###############"
    puts "Script output does not match expectation:"
    puts "#{sorted_script_catalog}\ndoes not match\n#{result_output_sorted_catalog}"
    false
  end
end

###################
# Start of script #
###################

# Get all the catalogs
all_catalogs = Dir.glob("./input/catalog*.csv")
  .sort
  .map { |file| CSV.read(file).drop(1).map { |e| CatalogItem.new(e[0], e[1], File.basename(file, ".csv")[-1]) } }
  .map { |e| Catalog.new(e) }

# Get all the barcodes
all_barcodes = Dir.glob("./input/barcodes*.csv")
  .sort
  .map { |e| CSV.read(e).drop(1).map { |e| Barcode.new(e[0], e[1], e[2]) } }

if all_catalogs.length < 2
  puts "There should be a minimum of 2 catalogs to be merged"
  exit 1
end

if all_catalogs.length != all_barcodes.length
  puts "There should be as many catalog as there is barcodes files"
  exit 1
end

# Create new merged catalog based on the first catalog
merged_catalog = all_catalogs.shift
merged_barcodes = all_barcodes.shift

# Extract each items into the merged catalog
loop do
  next_catalog = all_catalogs.shift
  next_barcodes = all_barcodes.shift

  extract_items(next_catalog, next_barcodes, merged_catalog, merged_barcodes)

  if all_catalogs.length == 0 || all_barcodes.length == 0
    break
  end
end

# Only write to an output if the tests is successful
if test(merged_catalog) then write_catalog_to_output_file("script_output", merged_catalog) end
