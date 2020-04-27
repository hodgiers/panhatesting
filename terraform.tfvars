#region="eu-north-1"
cidr="10.18.0.0/16"
subnets={
    public-1a  = { cidr = "10.18.0.0/24", az = "eu-north-1a", route_table = "public" },
    public-1b  = { cidr = "10.18.1.0/24", az = "eu-north-1b", route_table = "public" },
    private-1a = { cidr = "10.18.8.0/24", az = "eu-north-1a", route_table = "private" },
    private-1b = { cidr = "10.18.9.0/24", az = "eu-north-1b", route_table = "private" }
    tgw-1a     = { cidr = "10.18.18.0/24", az = "eu-north-1a", route_table = "tgw" },
    tgw-1b     = { cidr = "10.18.19.0/24", az = "eu-north-1b", route_table = "tgw" },
    ha-1a    = { cidr = "10.18.100.0/24", az = "eu-north-1a", route_table = "ha" },
    ha-1b    = { cidr = "10.18.110.0/24", az = "eu-north-1b", route_table = "ha" },
    mgmt-1a    = { cidr = "10.18.10.0/24", az = "eu-north-1a", route_table = "mgmt" },
    mgmt-1b    = { cidr = "10.18.11.0/24", az = "eu-north-1b", route_table = "mgmt" },
}
public_subnets = ["public"]
fw_ha_a_pri_name="fw-ha-a-pri"
fw_ha_a_sec_name="fw-ha-a-sec"
fw_ha_b_pri_name="fw-ha-b-pri"
fw_ha_b_sec_name="fw-ha-b-sec"
#fw_key_name="TD-24JAN20"
mgmt_a_subnet="mgmt-1a"
private_a_subnet="private-1a"
ha_a_subnet="ha-1a"
public_a_subnet="public-1a"
mgmt_b_subnet="mgmt-1b"
private_b_subnet="private-1b"
ha_b_subnet="ha-1b"
public_b_subnet="public-1b"
