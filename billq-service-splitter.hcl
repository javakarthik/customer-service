kind = "service-splitter",
name = "billq-service"

splits = [
  {
    weight = 50,
    service_subset = "v1"
  },
  {
    weight = 50,
    service_subset = "v2"
  }
]
