package br.com.pags.tdc;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello-world")
public class HelloWorldResource {

    @GetMapping
    public ResponseEntity<String> getHelloWorld(){
        return ResponseEntity.ok("Hello World! I am customer-api :)");
    }
}
