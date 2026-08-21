-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/RechargeExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.RechargeExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.GetRechargeInfoReply = protobuf.Descriptor()
field_descriptors.GetRechargeInfoReply_credit = protobuf.FieldDescriptor()
field_descriptors.GetRechargeInfoReply_accumulateReceived = protobuf.FieldDescriptor()
field_descriptors.GetRechargeInfoReply_firstStatus = protobuf.FieldDescriptor()
type_descriptors.ReceiveFirstReply = protobuf.Descriptor()
type_descriptors.GetRechargeInfoRequest = protobuf.Descriptor()
type_descriptors.ReceiveAccumulateReply = protobuf.Descriptor()
field_descriptors.ReceiveAccumulateReply_index = protobuf.FieldDescriptor()
type_descriptors.ReceiveFirstRequest = protobuf.Descriptor()
type_descriptors.ReceiveAccumulateRequest = protobuf.Descriptor()
field_descriptors.ReceiveAccumulateRequest_index = protobuf.FieldDescriptor()
field_descriptors.GetRechargeInfoReply_credit.name = "credit"
field_descriptors.GetRechargeInfoReply_credit.full_name = ".GetRechargeInfoReply.credit"
field_descriptors.GetRechargeInfoReply_credit.number = 1
field_descriptors.GetRechargeInfoReply_credit.index = 0
field_descriptors.GetRechargeInfoReply_credit.label = 1
field_descriptors.GetRechargeInfoReply_credit.has_default_value = false
field_descriptors.GetRechargeInfoReply_credit.default_value = 0
field_descriptors.GetRechargeInfoReply_credit.type = 5
field_descriptors.GetRechargeInfoReply_credit.cpp_type = 1
field_descriptors.GetRechargeInfoReply_accumulateReceived.name = "accumulateReceived"
field_descriptors.GetRechargeInfoReply_accumulateReceived.full_name = ".GetRechargeInfoReply.accumulateReceived"
field_descriptors.GetRechargeInfoReply_accumulateReceived.number = 2
field_descriptors.GetRechargeInfoReply_accumulateReceived.index = 1
field_descriptors.GetRechargeInfoReply_accumulateReceived.label = 3
field_descriptors.GetRechargeInfoReply_accumulateReceived.has_default_value = false
field_descriptors.GetRechargeInfoReply_accumulateReceived.default_value = {}
field_descriptors.GetRechargeInfoReply_accumulateReceived.type = 5
field_descriptors.GetRechargeInfoReply_accumulateReceived.cpp_type = 1
field_descriptors.GetRechargeInfoReply_firstStatus.name = "firstStatus"
field_descriptors.GetRechargeInfoReply_firstStatus.full_name = ".GetRechargeInfoReply.firstStatus"
field_descriptors.GetRechargeInfoReply_firstStatus.number = 3
field_descriptors.GetRechargeInfoReply_firstStatus.index = 2
field_descriptors.GetRechargeInfoReply_firstStatus.label = 1
field_descriptors.GetRechargeInfoReply_firstStatus.has_default_value = false
field_descriptors.GetRechargeInfoReply_firstStatus.default_value = 0
field_descriptors.GetRechargeInfoReply_firstStatus.type = 5
field_descriptors.GetRechargeInfoReply_firstStatus.cpp_type = 1
type_descriptors.GetRechargeInfoReply.name = "GetRechargeInfoReply"
type_descriptors.GetRechargeInfoReply.full_name = ".GetRechargeInfoReply"
type_descriptors.GetRechargeInfoReply.nested_types = {}
type_descriptors.GetRechargeInfoReply.enum_types = {}
type_descriptors.GetRechargeInfoReply.fields = {
	field_descriptors.GetRechargeInfoReply_credit,
	field_descriptors.GetRechargeInfoReply_accumulateReceived,
	field_descriptors.GetRechargeInfoReply_firstStatus
}
type_descriptors.GetRechargeInfoReply.is_extendable = false
type_descriptors.GetRechargeInfoReply.extensions = {}
type_descriptors.ReceiveFirstReply.name = "ReceiveFirstReply"
type_descriptors.ReceiveFirstReply.full_name = ".ReceiveFirstReply"
type_descriptors.ReceiveFirstReply.nested_types = {}
type_descriptors.ReceiveFirstReply.enum_types = {}
type_descriptors.ReceiveFirstReply.fields = {}
type_descriptors.ReceiveFirstReply.is_extendable = false
type_descriptors.ReceiveFirstReply.extensions = {}
type_descriptors.GetRechargeInfoRequest.name = "GetRechargeInfoRequest"
type_descriptors.GetRechargeInfoRequest.full_name = ".GetRechargeInfoRequest"
type_descriptors.GetRechargeInfoRequest.nested_types = {}
type_descriptors.GetRechargeInfoRequest.enum_types = {}
type_descriptors.GetRechargeInfoRequest.fields = {}
type_descriptors.GetRechargeInfoRequest.is_extendable = false
type_descriptors.GetRechargeInfoRequest.extensions = {}
field_descriptors.ReceiveAccumulateReply_index.name = "index"
field_descriptors.ReceiveAccumulateReply_index.full_name = ".ReceiveAccumulateReply.index"
field_descriptors.ReceiveAccumulateReply_index.number = 1
field_descriptors.ReceiveAccumulateReply_index.index = 0
field_descriptors.ReceiveAccumulateReply_index.label = 2
field_descriptors.ReceiveAccumulateReply_index.has_default_value = false
field_descriptors.ReceiveAccumulateReply_index.default_value = 0
field_descriptors.ReceiveAccumulateReply_index.type = 5
field_descriptors.ReceiveAccumulateReply_index.cpp_type = 1
type_descriptors.ReceiveAccumulateReply.name = "ReceiveAccumulateReply"
type_descriptors.ReceiveAccumulateReply.full_name = ".ReceiveAccumulateReply"
type_descriptors.ReceiveAccumulateReply.nested_types = {}
type_descriptors.ReceiveAccumulateReply.enum_types = {}
type_descriptors.ReceiveAccumulateReply.fields = {
	field_descriptors.ReceiveAccumulateReply_index
}
type_descriptors.ReceiveAccumulateReply.is_extendable = false
type_descriptors.ReceiveAccumulateReply.extensions = {}
type_descriptors.ReceiveFirstRequest.name = "ReceiveFirstRequest"
type_descriptors.ReceiveFirstRequest.full_name = ".ReceiveFirstRequest"
type_descriptors.ReceiveFirstRequest.nested_types = {}
type_descriptors.ReceiveFirstRequest.enum_types = {}
type_descriptors.ReceiveFirstRequest.fields = {}
type_descriptors.ReceiveFirstRequest.is_extendable = false
type_descriptors.ReceiveFirstRequest.extensions = {}
field_descriptors.ReceiveAccumulateRequest_index.name = "index"
field_descriptors.ReceiveAccumulateRequest_index.full_name = ".ReceiveAccumulateRequest.index"
field_descriptors.ReceiveAccumulateRequest_index.number = 1
field_descriptors.ReceiveAccumulateRequest_index.index = 0
field_descriptors.ReceiveAccumulateRequest_index.label = 2
field_descriptors.ReceiveAccumulateRequest_index.has_default_value = false
field_descriptors.ReceiveAccumulateRequest_index.default_value = 0
field_descriptors.ReceiveAccumulateRequest_index.type = 5
field_descriptors.ReceiveAccumulateRequest_index.cpp_type = 1
type_descriptors.ReceiveAccumulateRequest.name = "ReceiveAccumulateRequest"
type_descriptors.ReceiveAccumulateRequest.full_name = ".ReceiveAccumulateRequest"
type_descriptors.ReceiveAccumulateRequest.nested_types = {}
type_descriptors.ReceiveAccumulateRequest.enum_types = {}
type_descriptors.ReceiveAccumulateRequest.fields = {
	field_descriptors.ReceiveAccumulateRequest_index
}
type_descriptors.ReceiveAccumulateRequest.is_extendable = false
type_descriptors.ReceiveAccumulateRequest.extensions = {}
GetRechargeInfoReply = protobuf.Message(type_descriptors.GetRechargeInfoReply)
GetRechargeInfoRequest = protobuf.Message(type_descriptors.GetRechargeInfoRequest)
ReceiveAccumulateReply = protobuf.Message(type_descriptors.ReceiveAccumulateReply)
ReceiveAccumulateRequest = protobuf.Message(type_descriptors.ReceiveAccumulateRequest)
ReceiveFirstReply = protobuf.Message(type_descriptors.ReceiveFirstReply)
ReceiveFirstRequest = protobuf.Message(type_descriptors.ReceiveFirstRequest)

return _G["logic.proto.RechargeExtension_pb"]
