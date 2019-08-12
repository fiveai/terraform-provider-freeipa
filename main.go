package main

import (
	"github.com/fiveai/terraform-provider-freeipa/freeipa"
	"github.com/hashicorp/terraform/plugin"
	"github.com/hashicorp/terraform/terraform"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: func() terraform.ResourceProvider {
			return freeipa.Provider()
		},
	})
}
