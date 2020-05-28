package com.demo;
import com.demo.HeaderExchange;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

import org.springframework.beans.factory.annotation.Autowired;

@Configuration
@EnableConfigurationProperties(DemoProperties.class)
public class ReactiveServerConfig {

	/*@Autowired
	private HeaderExchange headerExchange;

    @Bean
    public WebClient webClient() {
        return WebClient
                .builder()
                .filter(headerExchange)
                .baseUrl(System.getenv("order-service"))
                .build();
    }*/
}
