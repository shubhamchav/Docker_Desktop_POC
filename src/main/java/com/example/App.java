package com.example;

import org.apache.commons.text.StringSubstitutor;

/**
 * Minimal app that references commons-text so the vulnerable library ships in the shaded JAR.
 * For security training / scanner POC only — do not deploy as-is.
 */
public class App {

    public static void main(String[] args) {
        var template = System.getenv().getOrDefault("DEMO_TEMPLATE", "Hello ${name}");
        var sub = new StringSubstitutor(java.util.Map.of("name", "ScannerPOC"));
        System.out.println(sub.replace(template));
    }
}
