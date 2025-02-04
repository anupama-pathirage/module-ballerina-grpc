// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep31 = new (9121);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_31_RETURN_UNARY,
    descMap: getDescriptorMap31ReturnUnary()
}
service "HelloWorld31" on ep31 {
    remote isolated function sayHello(SampleMsg31 reqMsg) returns ContextSampleMsg31|error {
        io:print("Received input for testRecordValueReturn: ");
        io:println(reqMsg);
        if reqMsg.name == "" {
            return error grpc:InvalidArgumentError("Name must not be empty.");
        }
        SampleMsg31 respMsg = {
            name: "Ballerina Lang",
            id: 7
        };
        return {content:respMsg, headers: {xxx: "yyy"}};
    }
}
