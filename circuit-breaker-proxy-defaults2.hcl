kind = "proxy-defaults"
name = "global"   
config {

         envoy_local_cluster_json = <<EOL
           {
             "@type": "type.googleapis.com/envoy.api.v2.Cluster",
             "name": "local_app",
             "connect_timeout": "5s",
             "circuit_breakers": {
               "thresholds": [
                 {
                   "priority": "HIGH",
                   "max_requests": 1
                 }
               ]
             },
             "load_assignment": {
              "cluster_name": "local_app",
              "endpoints": [
               {
                "lb_endpoints": [
                 {
                  "endpoint": {
                   "address": {
                    "socket_address": {
                     "address": "127.0.0.1",
                     "port_value": 8081
                    }
                   }
                  }
                 }
                ]
               }
              ]
             }
           }
        EOL

  envoy_cluster_json = <<EOL
              {
                "@type": "type.googleapis.com/envoy.api.v2.Cluster",
                "name": "upstream",
                "type": "EDS",
                "eds_cluster_config": {
                  "eds_config": {
                    "ads": {}
                  }
                },
                "connect_timeout": "5s",
                "outlier_detection": {
                  "consecutive_5xx": 10,
                  "consecutive_gateway_failure": 10,
                  "base_ejection_time": "30s"
                }
              }
            EOL
            
      envoy_listener_json = <<EOL
              {
              "@type": "type.googleapis.com/envoy.api.v2.Listener",
              "name": "upstream:127.0.0.1:8082",
              "address": {
                "socketAddress": {
                  "address": "127.0.0.1",
                  "portValue": 8082
                }
              },
              "filterChains": [
                {
                  "filters": [
                    {
                      "name": "envoy.http_connection_manager",
                      "config": {
                        "stat_prefix": "upstream",
                        "route_config": {
                          "name": "local_route",
                          "virtual_hosts": [
                            {
                              "name": "backend",
                              "domains": ["*"],
                              "routes": [
                                {
                                  "match": {
                                    "prefix": "/"
                                  },
                                  "route": {
                                    "cluster": "upstream",
                                    "timeout": "6s",
                                    "retry_policy": {
                                      "retry_on": "5xx",
                                      "num_retries": 5,
                                      "per_try_timeout": "2s"
                                    }
                                  }
                                }
                              ]
                            }
                          ]
                        },
                        "http_filters": [
                          {
                            "name": "envoy.router",
                            "config": {}
                          }
                        ]
                      }
                    }
                  ]
                }
              ]
            } 
        EOL
}      
