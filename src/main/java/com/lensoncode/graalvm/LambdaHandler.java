package com.lensoncode.graalvm;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class LambdaHandler implements RequestHandler<String, String> {

    public static void main(String[] arg) {
        System.out.println("Lambda ran successfully from main function!");
    }

    @Override
    public String handleRequest(String arg, Context context) {
        return "Lambda ran successfully from handler function !";
    }
}
