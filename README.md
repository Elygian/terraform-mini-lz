# terraform-mini-lz
A collection of terraform resources to spin up a mini landing zone style set of infrastructure

## Caveats
### Practicality of Design
I am not an architect, and do not pretend that the design of this infrastructure is sensible. It is meant purely as a demonstration of basic Terraform configuration.
### Resource Organisation
This IaC has been put together using a single, pre-existing resource group as it has been deployed in to a corporate sandbox I have access to through my employer. This means that any separation that would normally be done using resource groups (for example separating storage, networking, and compute resources into different RGs) is not possible.