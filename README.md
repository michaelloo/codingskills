# Getting started

## Toolset

### Script

- Ruby: 2.6.5

### Xcode project

- Xcode: 12.5
- MacOS: 11.3.1 (Big Sur)

## Generating the merged catalog

- To generate the merged catalog, the script `./merge_catalogs.rb` can be ran from command line.
It will output its results here: [output/script_output.csv](output/script_output.csv).
- There is a test method in the script directly to ensure any changes to the output is expected. The test will catch unintended logical errors.
However, it won't be able to tell if the changes are expected due to new entries in the data set.

## Script

- A *scripting language* was chosen for the exercise as it felt closer to the problem: reading from and writing to files.
- `Ruby` was chosen as it is closer to my day to day programming language: Swift.
- The solution is based on having barcodes as a way to identify a product across different catalogs (and suppliers).
If a barcode if found in the merged catalog whilst traversing the list, it would be skipped and we would move to the next item.
- The `result_output` has been renamed to `expected_output` as a way to differentiate between the script's output and what was expected (for testing).
- The `expected_output` file has been updated as new data set for catalogC and barcodeC were added
- The products in the output files have been sorted using their description and source as a way to more easily compare the changes lists (in the test and in git)

## Xcode Project

- Note: You will need Xcode (and therefore a macOS toolchain) in order to build & run the project.
- A simple Xcode project has been created to package the output of the script into an iOS app and then read on a simulator or device
- Open `CodingSkills.xcodeproj` with Xcode and the project is structured as follow:
    - CodingSkills (production code)
        - App (for application / view level code)
            - ViewModels (for business logic related to how the data is presented to users)
            - Views (for the user interface)
        - Network (for network level code)
    - CodingSkillsTests (tests code)
- Press `CMD+R` to run the application against the chosen device or simulator 
- Press `CMD+U` to run the tests
- Tests have been written to cover the core business logic (ignoring views for now)

---

# Coding Skills Challenge

### The below describes a problem statement, make sure to read all the instructions in this readme before you start.

### Business Requirement:

- Company A have acquired Company B, A and B sell some common products, sourced from suppliers (Sometimes the same supplier, sometimes a different one).
- The business wants to consolidate the product catalog into one superset (merged catalog).

### There are possibilities like:

- Company A and B could have conflicting product codes (SKUs).
- Product codes might be same, but they are different products.
- Product codes are different, but they are same product.
- You should not be duplicating product records in merged catalog.
- Product on merged catalog must have information about the company it belongs to originally.  

The business provided the following information that may help in identifying a matching product:
- Products have associated suppliers, each supplier provides 1 or many barcodes for a product,
- A product may have many suppliers,
- If any supplier barcode matches for one product of company A with Company B then we can consider that those products as the same.


So, you have following entities to play with:

<img src="./entity_diagram.png" width="800px" height="auto">



You need to produce code in your preferred language which can demonstrate following:

### Initial load
- Mega merge: All products from both companies should get merge into a common catalog


### Sample Data
Please refer input folder for following CSVs:
1. [catalogA.csv](input/catalogA.csv) - Products for Company A
1. [catalogB.csv](input/catalogB.csv) - Products for Company B
1. [suppliersA.csv](input/suppliersA.csv) - List of Suppliers for Company A
1. [suppliersB.csv](input/suppliersB.csv) - List of Suppliers for Company B
1. [barcodesA.csv](input/barcodesA.csv) - Product barcodes provided by supplier for company A
1. [barcodesB.csv](input/barcodesB.csv) - Product barcodes provided by supplier for company B
1. [result_output.csv](output/result_output.csv) - The correct results based on the above sample data


### Deliverables.
- Application should be able to accept above data as csv files from input folder and must produce a merged catalog as a csv file in output folder.
- Proving your code works via unit testing is highly encouraged.
- Spend as little or as much time as you like ⌚
- The code you produce can be in any language ⭐
- The output of the efforts ❗ must be committed back into a Public Repo in Github and the URL shared back for review.
- Document instructions on how to install and run your solution in the README.
