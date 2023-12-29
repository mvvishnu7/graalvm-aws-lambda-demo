package com.lensoncode.graalvm;

import com.amazonaws.services.lambda.runtime.Context;

public class LambdaHandler {

  public static String handleRequest(String arg, Context context) {
    return arg;
  }
}
