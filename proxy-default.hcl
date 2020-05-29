kind = "proxy-defaults"
name = "global"   
config {
    envoy_extra_static_clusters_json = <<EOL
    {
        "connect_timeout": "3.000s",
        "dns_lookup_family": "V4_ONLY",
        "lb_policy": "ROUND_ROBIN",
        "load_assignment": {
            "cluster_name": "jaeger",
            "endpoints": [
                {
                    "lb_endpoints": [
                        {
                            "endpoint": {
                                "address": {
                                    "socket_address": {
                                    "address": "10.106.35.113",
                                    "port_value": 9411,
                                    "protocol": "TCP"
                                    }
                                }
                            }
                        }
                    ]
                }
            ]
        },
        "name": "jaeger",
        "type": "STRICT_DNS"
    }
    EOL

    envoy_tracing_json = <<EOL
    {
        "http": {
            "name": "envoy.zipkin",
            "config": {
                "collector_cluster": "jaeger",
                "collector_endpoint": "/api/v1/spans"
                }
            }
    }
    EOL
}
    