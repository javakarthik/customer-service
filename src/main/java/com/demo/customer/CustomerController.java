package com.demo.customer;

import brave.sampler.Sampler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpHeaders;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import org.springframework.http.MediaType;

import java.awt.*;
import java.util.Arrays;
import java.util.List;

@EnableAutoConfiguration
@RestController
@Slf4j
public class CustomerController {

    @Autowired
    WebClient webClient;


    @GetMapping(value = "/v1/customers/{id}",produces = MediaType.APPLICATION_JSON_VALUE)
    public Mono<String> getCustomerOrder(@PathVariable String id){
        log.info("CustomerController");
        System.out.println("Id :"+id);
        List<String> customers = Arrays.asList("NA","John", "Peter", "Ronnie");
        String customer = customers.get(Integer.parseInt(id));
        /*System.out.println("Customer name :"+customer);
        Mono<String> customerMono;
        customerMono = Mono.just(customer).log();*/
        Mono<String> customerOrder = webClient.get().uri("/v1/orders/{id}",id)
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .retrieve()
                .bodyToMono(String.class)
                .map(orderBill-> customer + orderBill)
                .log("Customer order: ");

        return customerOrder;
       /* return */
    }
/*
    @Bean
    WebClient webClient() {
        return WebClient.create(System.getenv("order-service"));
    }*/


}
