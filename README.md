<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform Azure Network Security Group
</h1>

<p align="center" style="font-size: 1.2rem;">
    Terraform module to create Network Security Group resource on Azure.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.7.4-green" alt="Terraform">
</a>
<a href="https://github.com/slovink/terraform-azure-network-security-group/blob/dev/LICENSE">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


## Prerequisites

This module has a few dependencies:

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/slovink/terraform-azure-network-security-group).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
  ```hcl
module "network_security_group" {
  depends_on              = [module.subnet]
  resource_group_location = module.resource_group.resource_group_location
  source                  = "https://github.com/slovink/terraform-azure-network-security-group.git?ref=1.0.0"
  label_order             = ["name", "environment"]
  app_name                = "app"
  environment             = "test"
  subnet_ids              = module.subnet.default_subnet_id
  resource_group_name     = module.resource_group.resource_group_name
  inbound_rules = [
    {
      name = "ssh"
      priority = 101
      access = "Allow"
      protocol = "Tcp"
      source_address_prefix = "67.23.123.234/32"
      source_port_range = "*"
      destination_address_prefix = "0.0.0.0/0"
      destination_port_range = "22"
      description = "ssh allowed port"
    },
    {
      name = "https"
      priority = 102
      access = "Allow"
      protocol = "Tcp"
      source_address_prefix = "*"
      source_port_range = "*"
      destination_address_prefix = "0.0.0.0/0"
      destination_port_range = "22"
      description = "ssh allowed port"
    }
  ]
}
  ```

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/slovink/terraform-azure-Network-security-group/blob/dev/LICENSE) file for details.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/slovink/terraform-azure-network-security-group/tree/dev/_example) directory within this repository.


## Feedback
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/slovink/terraform-azure-network-security-group), or feel free to drop us an email at [contact@slovink.com](contact@slovink.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/slovink/terraform-azure-network-security-group)!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::git@github.com:slovink/terraform-azure-labels.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet_network_security_group_association.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Used when creating the Resource Group. | `string` | `"30m"` | no |
| <a name="input_delete"></a> [delete](#input\_delete) | Used when deleting the Resource Group. | `string` | `"30m"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_inbound_rules"></a> [inbound\_rules](#input\_inbound\_rules) | List of objects that represent the configuration of each inbound rule. | `list(map(string))` | `[]` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | `[]` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | managedby, slovink | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_outbound_rules"></a> [outbound\_rules](#input\_outbound\_rules) | List of objects that represent the configuration of each outbound rule. | `list(map(string))` | `[]` | no |
| <a name="input_read"></a> [read](#input\_read) | Used when retrieving the Resource Group. | `string` | `"5m"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `""` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | The Location of the resource group where to create the network security group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the network security group. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The ID of the Subnet. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_update"></a> [update](#input\_update) | Used when updating the Resource Group. | `string` | `"30m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The network security group configuration ID. |
| <a name="output_name"></a> [name](#output\_name) | The name of the network security group. |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags assigned to the resource. |
<!-- END_TF_DOCS -->