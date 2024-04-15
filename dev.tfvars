location                   = "australiaeast"
virtual_net                = "VNET_SC_PRIVATE_NONPROD_AUE"
project_ips_public           = ["200.100.111.64/27", "200.8.130.0/28"]
subnet_name                = ["SUBNE_TON_TRA_PE_DEV_AUE"]
subnet_resource_group_name = "RG_CSVC_BASE_PRIVATE_NONPROD_AUE"
resource_group_name        = "RG_TON__DATA_DEV_AUE"
account_replication_type   = "LRS"

cloudadmin_objectid = "097y88u48u494u9449i4i04i404i40i4" 
cloudadmin_object_name = "TON-CloudNonProdAdmin"

sc_uai_objectid = "8889999926e9-0000-0000-678999"


environment   = "dev"
locationshort = "aue"
tags = {
  Environment = "DEV"
}

# key vault

akv_config = {
  name = "kv-ton"

  akv_features = {
    enabled_for_disk_encryption     = true
    enabled_for_deployment          = false
    enabled_for_template_deployment = true
  }

  sku_name = "standard"
}