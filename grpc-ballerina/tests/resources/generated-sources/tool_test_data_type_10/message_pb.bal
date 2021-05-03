public type ByeResponse record {|
    string say = "";
|};

public type ByeRequest record {|
    string greet = "";
|};

const string ROOT_DESCRIPTOR = "0A0D6D6573736167652E70726F746F22220A0A4279655265717565737412140A05677265657418012001280952056772656574221F0A0B427965526573706F6E736512100A037361791801200128095203736179620670726F746F33";

isolated function getDescriptorMap() returns map<string> {
    return 
    {"message.proto": "0A0D6D6573736167652E70726F746F22220A0A4279655265717565737412140A05677265657418012001280952056772656574221F0A0B427965526573706F6E736512100A037361791801200128095203736179620670726F746F33"};
}
