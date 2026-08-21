-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/SystemOpenExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.SystemOpenExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.ConditionUnlockedPush = protobuf.Descriptor()
field_descriptors.ConditionUnlockedPush_bitIndex = protobuf.FieldDescriptor()
field_descriptors.ConditionUnlockedPush_codes = protobuf.FieldDescriptor()
type_descriptors.ClientOpenSystemReply = protobuf.Descriptor()
type_descriptors.GetSystemOpenInfoReply = protobuf.Descriptor()
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked = protobuf.FieldDescriptor()
field_descriptors.GetSystemOpenInfoReply_offlines = protobuf.FieldDescriptor()
type_descriptors.ClientOpenSystemRequest = protobuf.Descriptor()
field_descriptors.ClientOpenSystemRequest_code = protobuf.FieldDescriptor()
type_descriptors.GetSystemOpenInfoRequest = protobuf.Descriptor()
type_descriptors.SystemAndConditionNO = protobuf.Descriptor()
field_descriptors.SystemAndConditionNO_code = protobuf.FieldDescriptor()
field_descriptors.SystemAndConditionNO_bits = protobuf.FieldDescriptor()
type_descriptors.CloseSystemEntryPush = protobuf.Descriptor()
field_descriptors.CloseSystemEntryPush_codes = protobuf.FieldDescriptor()
field_descriptors.ConditionUnlockedPush_bitIndex.name = "bitIndex"
field_descriptors.ConditionUnlockedPush_bitIndex.full_name = ".ConditionUnlockedPush.bitIndex"
field_descriptors.ConditionUnlockedPush_bitIndex.number = 1
field_descriptors.ConditionUnlockedPush_bitIndex.index = 0
field_descriptors.ConditionUnlockedPush_bitIndex.label = 1
field_descriptors.ConditionUnlockedPush_bitIndex.has_default_value = false
field_descriptors.ConditionUnlockedPush_bitIndex.default_value = 0
field_descriptors.ConditionUnlockedPush_bitIndex.type = 5
field_descriptors.ConditionUnlockedPush_bitIndex.cpp_type = 1
field_descriptors.ConditionUnlockedPush_codes.name = "codes"
field_descriptors.ConditionUnlockedPush_codes.full_name = ".ConditionUnlockedPush.codes"
field_descriptors.ConditionUnlockedPush_codes.number = 2
field_descriptors.ConditionUnlockedPush_codes.index = 1
field_descriptors.ConditionUnlockedPush_codes.label = 3
field_descriptors.ConditionUnlockedPush_codes.has_default_value = false
field_descriptors.ConditionUnlockedPush_codes.default_value = {}
field_descriptors.ConditionUnlockedPush_codes.type = 5
field_descriptors.ConditionUnlockedPush_codes.cpp_type = 1
type_descriptors.ConditionUnlockedPush.name = "ConditionUnlockedPush"
type_descriptors.ConditionUnlockedPush.full_name = ".ConditionUnlockedPush"
type_descriptors.ConditionUnlockedPush.nested_types = {}
type_descriptors.ConditionUnlockedPush.enum_types = {}
type_descriptors.ConditionUnlockedPush.fields = {
	field_descriptors.ConditionUnlockedPush_bitIndex,
	field_descriptors.ConditionUnlockedPush_codes
}
type_descriptors.ConditionUnlockedPush.is_extendable = false
type_descriptors.ConditionUnlockedPush.extensions = {}
type_descriptors.ClientOpenSystemReply.name = "ClientOpenSystemReply"
type_descriptors.ClientOpenSystemReply.full_name = ".ClientOpenSystemReply"
type_descriptors.ClientOpenSystemReply.nested_types = {}
type_descriptors.ClientOpenSystemReply.enum_types = {}
type_descriptors.ClientOpenSystemReply.fields = {}
type_descriptors.ClientOpenSystemReply.is_extendable = false
type_descriptors.ClientOpenSystemReply.extensions = {}
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.name = "maybeUnlocked"
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.full_name = ".GetSystemOpenInfoReply.maybeUnlocked"
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.number = 1
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.index = 0
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.label = 3
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.has_default_value = false
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.default_value = {}
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.message_type = type_descriptors.SystemAndConditionNO
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.type = 11
field_descriptors.GetSystemOpenInfoReply_maybeUnlocked.cpp_type = 10
field_descriptors.GetSystemOpenInfoReply_offlines.name = "offlines"
field_descriptors.GetSystemOpenInfoReply_offlines.full_name = ".GetSystemOpenInfoReply.offlines"
field_descriptors.GetSystemOpenInfoReply_offlines.number = 2
field_descriptors.GetSystemOpenInfoReply_offlines.index = 1
field_descriptors.GetSystemOpenInfoReply_offlines.label = 3
field_descriptors.GetSystemOpenInfoReply_offlines.has_default_value = false
field_descriptors.GetSystemOpenInfoReply_offlines.default_value = {}
field_descriptors.GetSystemOpenInfoReply_offlines.type = 5
field_descriptors.GetSystemOpenInfoReply_offlines.cpp_type = 1
type_descriptors.GetSystemOpenInfoReply.name = "GetSystemOpenInfoReply"
type_descriptors.GetSystemOpenInfoReply.full_name = ".GetSystemOpenInfoReply"
type_descriptors.GetSystemOpenInfoReply.nested_types = {}
type_descriptors.GetSystemOpenInfoReply.enum_types = {}
type_descriptors.GetSystemOpenInfoReply.fields = {
	field_descriptors.GetSystemOpenInfoReply_maybeUnlocked,
	field_descriptors.GetSystemOpenInfoReply_offlines
}
type_descriptors.GetSystemOpenInfoReply.is_extendable = false
type_descriptors.GetSystemOpenInfoReply.extensions = {}
field_descriptors.ClientOpenSystemRequest_code.name = "code"
field_descriptors.ClientOpenSystemRequest_code.full_name = ".ClientOpenSystemRequest.code"
field_descriptors.ClientOpenSystemRequest_code.number = 1
field_descriptors.ClientOpenSystemRequest_code.index = 0
field_descriptors.ClientOpenSystemRequest_code.label = 3
field_descriptors.ClientOpenSystemRequest_code.has_default_value = false
field_descriptors.ClientOpenSystemRequest_code.default_value = {}
field_descriptors.ClientOpenSystemRequest_code.type = 5
field_descriptors.ClientOpenSystemRequest_code.cpp_type = 1
type_descriptors.ClientOpenSystemRequest.name = "ClientOpenSystemRequest"
type_descriptors.ClientOpenSystemRequest.full_name = ".ClientOpenSystemRequest"
type_descriptors.ClientOpenSystemRequest.nested_types = {}
type_descriptors.ClientOpenSystemRequest.enum_types = {}
type_descriptors.ClientOpenSystemRequest.fields = {
	field_descriptors.ClientOpenSystemRequest_code
}
type_descriptors.ClientOpenSystemRequest.is_extendable = false
type_descriptors.ClientOpenSystemRequest.extensions = {}
type_descriptors.GetSystemOpenInfoRequest.name = "GetSystemOpenInfoRequest"
type_descriptors.GetSystemOpenInfoRequest.full_name = ".GetSystemOpenInfoRequest"
type_descriptors.GetSystemOpenInfoRequest.nested_types = {}
type_descriptors.GetSystemOpenInfoRequest.enum_types = {}
type_descriptors.GetSystemOpenInfoRequest.fields = {}
type_descriptors.GetSystemOpenInfoRequest.is_extendable = false
type_descriptors.GetSystemOpenInfoRequest.extensions = {}
field_descriptors.SystemAndConditionNO_code.name = "code"
field_descriptors.SystemAndConditionNO_code.full_name = ".SystemAndConditionNO.code"
field_descriptors.SystemAndConditionNO_code.number = 1
field_descriptors.SystemAndConditionNO_code.index = 0
field_descriptors.SystemAndConditionNO_code.label = 1
field_descriptors.SystemAndConditionNO_code.has_default_value = false
field_descriptors.SystemAndConditionNO_code.default_value = 0
field_descriptors.SystemAndConditionNO_code.type = 5
field_descriptors.SystemAndConditionNO_code.cpp_type = 1
field_descriptors.SystemAndConditionNO_bits.name = "bits"
field_descriptors.SystemAndConditionNO_bits.full_name = ".SystemAndConditionNO.bits"
field_descriptors.SystemAndConditionNO_bits.number = 2
field_descriptors.SystemAndConditionNO_bits.index = 1
field_descriptors.SystemAndConditionNO_bits.label = 1
field_descriptors.SystemAndConditionNO_bits.has_default_value = false
field_descriptors.SystemAndConditionNO_bits.default_value = 0
field_descriptors.SystemAndConditionNO_bits.type = 5
field_descriptors.SystemAndConditionNO_bits.cpp_type = 1
type_descriptors.SystemAndConditionNO.name = "SystemAndConditionNO"
type_descriptors.SystemAndConditionNO.full_name = ".SystemAndConditionNO"
type_descriptors.SystemAndConditionNO.nested_types = {}
type_descriptors.SystemAndConditionNO.enum_types = {}
type_descriptors.SystemAndConditionNO.fields = {
	field_descriptors.SystemAndConditionNO_code,
	field_descriptors.SystemAndConditionNO_bits
}
type_descriptors.SystemAndConditionNO.is_extendable = false
type_descriptors.SystemAndConditionNO.extensions = {}
field_descriptors.CloseSystemEntryPush_codes.name = "codes"
field_descriptors.CloseSystemEntryPush_codes.full_name = ".CloseSystemEntryPush.codes"
field_descriptors.CloseSystemEntryPush_codes.number = 1
field_descriptors.CloseSystemEntryPush_codes.index = 0
field_descriptors.CloseSystemEntryPush_codes.label = 3
field_descriptors.CloseSystemEntryPush_codes.has_default_value = false
field_descriptors.CloseSystemEntryPush_codes.default_value = {}
field_descriptors.CloseSystemEntryPush_codes.type = 5
field_descriptors.CloseSystemEntryPush_codes.cpp_type = 1
type_descriptors.CloseSystemEntryPush.name = "CloseSystemEntryPush"
type_descriptors.CloseSystemEntryPush.full_name = ".CloseSystemEntryPush"
type_descriptors.CloseSystemEntryPush.nested_types = {}
type_descriptors.CloseSystemEntryPush.enum_types = {}
type_descriptors.CloseSystemEntryPush.fields = {
	field_descriptors.CloseSystemEntryPush_codes
}
type_descriptors.CloseSystemEntryPush.is_extendable = false
type_descriptors.CloseSystemEntryPush.extensions = {}
ClientOpenSystemReply = protobuf.Message(type_descriptors.ClientOpenSystemReply)
ClientOpenSystemRequest = protobuf.Message(type_descriptors.ClientOpenSystemRequest)
CloseSystemEntryPush = protobuf.Message(type_descriptors.CloseSystemEntryPush)
ConditionUnlockedPush = protobuf.Message(type_descriptors.ConditionUnlockedPush)
GetSystemOpenInfoReply = protobuf.Message(type_descriptors.GetSystemOpenInfoReply)
GetSystemOpenInfoRequest = protobuf.Message(type_descriptors.GetSystemOpenInfoRequest)
SystemAndConditionNO = protobuf.Message(type_descriptors.SystemAndConditionNO)

return _G["logic.proto.SystemOpenExtension_pb"]
