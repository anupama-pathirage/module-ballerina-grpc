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
import ballerina/test;
import ballerina/protobuf.types.wrappers;

@test:Config {
    enable: true,
    groups: ["ldap"]
}
isolated function testStringValueReturnWithLdapAuth() returns grpc:Error? {
    if !isWindowsEnvironment() {
        HelloWorld52Client helloWorldEp = check new ("http://localhost:9152");
        map<string|string[]> requestHeaders = {};

        grpc:CredentialsConfig config = {
            username: "alice",
            password: "alice@123"
        };

        grpc:ClientBasicAuthHandler handler = new (config);
        map<string|string[]>|grpc:ClientAuthError result = handler.enrich(requestHeaders);
        if result is grpc:ClientAuthError {
            test:assertFail(msg = "Test Failed! " + result.message());
        } else {
            requestHeaders = result;
        }

        wrappers:ContextString requestMessage = {
            content: "WSO2",
            headers: requestHeaders
        };
        var response = helloWorldEp->testStringValueReturn(requestMessage);
        if response is grpc:Error {
            test:assertFail(msg = response.message());
        } else {
            test:assertEquals(response, "Hello WSO2");
        }
    }
}

@test:Config {
    enable: true,
    groups: ["ldap"]
}
isolated function testStringValueReturnWithInvalidLdapAuth() returns grpc:Error? {
    if !isWindowsEnvironment() {
        HelloWorld52Client helloWorldEp = check new ("http://localhost:9152");
        map<string|string[]> requestHeaders = {};

        grpc:CredentialsConfig config = {
            username: "admin",
            password: "1234"
        };

        grpc:ClientBasicAuthHandler handler = new (config);
        map<string|string[]>|grpc:ClientAuthError result = handler.enrich(requestHeaders);
        if result is grpc:ClientAuthError {
            test:assertFail(msg = "Test Failed! " + result.message());
        } else {
            requestHeaders = result;
        }

        wrappers:ContextString requestMessage = {
            content: "WSO2",
            headers: requestHeaders
        };
        var response = helloWorldEp->testStringValueReturn(requestMessage);
        if response is grpc:Error {
            test:assertEquals(response.message(), "Failed to authenticate username '" + config.username + "' with LDAP user store.");
        } else {
            test:assertFail(msg = "Expected grpc:Error not found.");
        }
    }
}

@test:Config {
    enable: true,
    groups: ["ldap"]
}
isolated function testStringValueReturnWithEmptyLdapAuth() returns grpc:Error? {
    if !isWindowsEnvironment() {
        HelloWorld52Client helloWorldEp = check new ("http://localhost:9152");
        map<string|string[]> requestHeaders = {
            "authorization": "Bearer "
        };

        wrappers:ContextString requestMessage = {
            content: "WSO2",
            headers: requestHeaders
        };
        var response = helloWorldEp->testStringValueReturn(requestMessage);
        if response is grpc:Error {
            test:assertEquals(response.message(), "Empty authentication header.");
        } else {
            test:assertFail(msg = "Expected grpc:Error not found.");
        }
    }
}

@test:Config {
    enable: true,
    groups: ["ldap"]
}
isolated function testStringValueReturnWithUnauthorizedLdapAuth() returns grpc:Error? {
    if !isWindowsEnvironment() {
        HelloWorld52Client helloWorldEp = check new ("http://localhost:9152");
        map<string|string[]> requestHeaders = {};

        grpc:CredentialsConfig config = {
            username: "bob",
            password: "bobgreen@123"
        };

        grpc:ClientBasicAuthHandler handler = new (config);
        map<string|string[]>|grpc:ClientAuthError result = handler.enrich(requestHeaders);
        if result is grpc:ClientAuthError {
            test:assertFail(msg = "Test Failed! " + result.message());
        } else {
            requestHeaders = result;
        }

        wrappers:ContextString requestMessage = {
            content: "WSO2",
            headers: requestHeaders
        };
        var response = helloWorldEp->testStringValueReturn(requestMessage);
        if response is grpc:Error {
            test:assertEquals(response.message(), "Permission denied");
        } else {
            test:assertFail(msg = "Expected grpc:Error not found.");
        }
    }
}

