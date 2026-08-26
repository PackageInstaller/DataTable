-- chunkname: @modules/proto/GlobalVoteModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.GlobalVoteModule_pb", package.seeall)

local GlobalVoteModule_pb = {}

GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG = protobuf.Descriptor()
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG = protobuf.Descriptor()
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG = protobuf.Descriptor()
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG = protobuf.Descriptor()
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD = protobuf.FieldDescriptor()
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.name = "voteId"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.full_name = ".GlobalVoteGetInfoRequest.voteId"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.number = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.index = 0
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.label = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.default_value = 0
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.type = 5
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD.cpp_type = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.name = "GlobalVoteGetInfoRequest"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.full_name = ".GlobalVoteGetInfoRequest"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.nested_types = {}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.enum_types = {}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.fields = {
	GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUESTVOTEIDFIELD
}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.is_extendable = false
GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG.extensions = {}
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.name = "optionId"
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.full_name = ".GlobalOptionResult.optionId"
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.number = 1
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.index = 0
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.label = 1
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.default_value = 0
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.type = 5
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD.cpp_type = 1
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.name = "optionResult"
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.full_name = ".GlobalOptionResult.optionResult"
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.number = 2
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.index = 1
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.label = 1
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.default_value = 0
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.type = 4
GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD.cpp_type = 4
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.name = "GlobalOptionResult"
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.full_name = ".GlobalOptionResult"
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.nested_types = {}
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.enum_types = {}
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.fields = {
	GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONIDFIELD,
	GlobalVoteModule_pb.GLOBALOPTIONRESULTOPTIONRESULTFIELD
}
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.is_extendable = false
GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG.extensions = {}
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.name = "voteId"
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.full_name = ".GlobalVoteInfo.voteId"
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.number = 1
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.index = 0
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.label = 1
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.default_value = 0
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.type = 5
GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD.cpp_type = 1
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.name = "optionResults"
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.full_name = ".GlobalVoteInfo.optionResults"
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.number = 2
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.index = 1
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.label = 3
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.default_value = {}
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.message_type = GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.type = 11
GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD.cpp_type = 10
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.name = "GlobalVoteInfo"
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.full_name = ".GlobalVoteInfo"
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.nested_types = {}
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.enum_types = {}
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.fields = {
	GlobalVoteModule_pb.GLOBALVOTEINFOVOTEIDFIELD,
	GlobalVoteModule_pb.GLOBALVOTEINFOOPTIONRESULTSFIELD
}
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.is_extendable = false
GlobalVoteModule_pb.GLOBALVOTEINFO_MSG.extensions = {}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.name = "voteId"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.full_name = ".GlobalVoteGetInfoReply.voteId"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.number = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.index = 0
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.label = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.default_value = 0
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.type = 5
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD.cpp_type = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.name = "voteInfo"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.full_name = ".GlobalVoteGetInfoReply.voteInfo"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.number = 2
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.index = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.label = 1
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.has_default_value = false
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.default_value = nil
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.message_type = GlobalVoteModule_pb.GLOBALVOTEINFO_MSG
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.type = 11
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD.cpp_type = 10
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.name = "GlobalVoteGetInfoReply"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.full_name = ".GlobalVoteGetInfoReply"
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.nested_types = {}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.enum_types = {}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.fields = {
	GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEIDFIELD,
	GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLYVOTEINFOFIELD
}
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.is_extendable = false
GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG.extensions = {}
GlobalVoteModule_pb.GlobalOptionResult = protobuf.Message(GlobalVoteModule_pb.GLOBALOPTIONRESULT_MSG)
GlobalVoteModule_pb.GlobalVoteGetInfoReply = protobuf.Message(GlobalVoteModule_pb.GLOBALVOTEGETINFOREPLY_MSG)
GlobalVoteModule_pb.GlobalVoteGetInfoRequest = protobuf.Message(GlobalVoteModule_pb.GLOBALVOTEGETINFOREQUEST_MSG)
GlobalVoteModule_pb.GlobalVoteInfo = protobuf.Message(GlobalVoteModule_pb.GLOBALVOTEINFO_MSG)

return GlobalVoteModule_pb
