#!/usr/bin/env ruby

require 'csv'
require 'set'

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

# Writes the given catalog to a given output file name
def write_catalog_to_output_file(file_name, catalog)
  output_file = File.open("./output/#{file_name}.csv", "w")
  output_file.puts "SKU,Description,Source"
  sort(catalog).each { |e| output_file.puts "#{e.sku},#{e.description},#{e.source}" }
  output_file.close
end

# Tests the scripts output
def test(script_output)
  sorted_script_catalog = sort(script_output.to_a)
  result_output_catalog = CSV.read("./output/result_output.csv").drop(1)
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

# Data models to better reason about the problem
CatalogItem = Struct.new(:sku, :description, :source)
Barcode = Struct.new(:supplier_id, :sku, :id)
Supplier = Struct.new(:id, :name)

# Read catalog files and add the additional source information
catalog_a = read_csv_from_file_named("catalogA").map { |e| CatalogItem.new(e[0], e[1], "A") }
catalog_b = read_csv_from_file_named("catalogB").map { |e| CatalogItem.new(e[0], e[1], "B") }

# Read barcode files
barcodes_a = read_csv_from_file_named("barcodesA").map { |e| Barcode.new(e[0], e[1], e[2]) }
barcodes_b = read_csv_from_file_named("barcodesB").map { |e| Barcode.new(e[0], e[1], e[2]) }

# Create new merged catalog based on the original's company data
# We use a Set here to avoid duplicate entries
merged_catalog = catalog_a.to_set

# Go through each items in the catalog from Company B
catalog_b.each do |catalog_item|

  # Select each barcodes that corresponds to the item's SKU we are inspecting
  barcodes = barcodes_b.select { |e| e.sku == catalog_item.sku }

  # Find a matching barcode from Company A's stock
  found_match = false
  barcodes_a.each do |barcode_a|
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

# Only write to an output if the tests is successful
if test(merged_catalog) then write_catalog_to_output_file("script_output", merged_catalog) end
