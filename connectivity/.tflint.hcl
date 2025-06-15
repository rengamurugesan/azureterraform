plugin "azurerm" {
    enabled = true
    version = "0.28.0"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

config {
  call_module_type = "all"
}

rule "terraform_required_version" {
  enabled = false
}

# Disallow variables, data sources, and locals that are declared but never used
rule "terraform_unused_declarations" { enabled = true }

# Disallow deprecated (0.11-style) interpolation
rule "terraform_deprecated_interpolation" {
enabled = true
}

# Disallow legacy dot index syntax.
rule "terraform_deprecated_index" {
enabled = true
}

# Check that all required_providers are used in the module
rule "terraform_unused_required_providers" {
    enabled = true
}
# Disallow deprecated lookup() function with only 2 arguments.
rule "terraform_deprecated_lookup" {
    enabled = true
}

# Disallow variables, data sources, and locals that are declared but never used.
rule "terraform_unused_declarations" {
enabled = true
}

# Disallow // comments in favor of #.
rule "terraform_comment_syntax" {
enabled = false
}

# Disallow output declarations without description.
rule "terraform_documented_outputs" {
enabled = true
}

# Disallow variable declarations without description.
rule "terraform_documented_variables" {
enabled = true
}

# Disallow variable declarations without type.
rule "terraform_typed_variables" {
enabled = true
}

#Disallow duplicate keys in a map object
rule "terraform_map_duplicate_keys" {
    enabled = true
}

# Disallow specifying a git or mercurial repository as a module source without pinning to a version
rule "terraform_module_pinned_source" {
    enabled = true 
}
# Disallow comparisons with [] when checking if a collection is empty
rule "terraform_empty_list_equality" {
    enabled = true

}
# Disallow specifying a git or mercurial repository as a module source without pinning to a version.
rule "terraform_module_pinned_source" {
enabled = true
}

# Enforces naming conventions
rule "terraform_naming_convention" {
enabled = true

#Require specific naming structure
variable {
format = "snake_case"
}

locals {
format = "snake_case"
}

output {
format = "snake_case"
}

#Allow any format
resource {
format = "none"
}

module {
format = "none"
}

data {
format = "none"
}

}



