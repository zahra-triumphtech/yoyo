#creates 3  S3 endpoints 
resource "aws_vpc_endpoint" "s3" {
  for_each     = toset(["s3-endpoint-1", "s3-endpoint-2", "s3-endpoint-3"])
  vpc_id       = aws_vpc.Endpoint_vpc.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

#adds route to each s3 endpoint

resource "aws_route" "s3_route" {
  for_each         = aws_vpc_endpoint.s3
  route_table_id   = aws_route_table.endpoint_tgw[each.value.vpc_id].id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id = each.value.id
}
