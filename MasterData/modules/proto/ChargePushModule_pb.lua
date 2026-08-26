-- chunkname: @modules/proto/ChargePushModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.ChargePushModule_pb", package.seeall)

local ChargePushModule_pb = {}

ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG = protobuf.Descriptor()
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD = protobuf.FieldDescriptor()
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG = protobuf.Descriptor()
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG = protobuf.Descriptor()
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD = protobuf.FieldDescriptor()
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG = protobuf.Descriptor()
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG = protobuf.Descriptor()
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD = protobuf.FieldDescriptor()
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.name = "id"
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.full_name = ".RecordChargePushRequest.id"
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.number = 1
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.index = 0
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.label = 1
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.has_default_value = false
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.default_value = 0
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.type = 5
ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD.cpp_type = 1
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.name = "RecordChargePushRequest"
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.full_name = ".RecordChargePushRequest"
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.nested_types = {}
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.enum_types = {}
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.fields = {
	ChargePushModule_pb.RECORDCHARGEPUSHREQUESTIDFIELD
}
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.is_extendable = false
ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG.extensions = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.name = "GetChargePushInfoReply"
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.full_name = ".GetChargePushInfoReply"
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.nested_types = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.enum_types = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.fields = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.is_extendable = false
ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG.extensions = {}
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.name = "pushId"
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.full_name = ".GetChargePushPush.pushId"
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.number = 1
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.index = 0
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.label = 3
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.has_default_value = false
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.default_value = {}
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.type = 5
ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD.cpp_type = 1
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.name = "GetChargePushPush"
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.full_name = ".GetChargePushPush"
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.nested_types = {}
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.enum_types = {}
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.fields = {
	ChargePushModule_pb.GETCHARGEPUSHPUSHPUSHIDFIELD
}
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.is_extendable = false
ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG.extensions = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.name = "GetChargePushInfoRequest"
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.full_name = ".GetChargePushInfoRequest"
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.nested_types = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.enum_types = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.fields = {}
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.is_extendable = false
ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG.extensions = {}
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.name = "id"
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.full_name = ".RecordChargePushReply.id"
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.number = 1
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.index = 0
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.label = 1
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.has_default_value = false
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.default_value = 0
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.type = 5
ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD.cpp_type = 1
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.name = "RecordChargePushReply"
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.full_name = ".RecordChargePushReply"
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.nested_types = {}
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.enum_types = {}
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.fields = {
	ChargePushModule_pb.RECORDCHARGEPUSHREPLYIDFIELD
}
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.is_extendable = false
ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG.extensions = {}
ChargePushModule_pb.GetChargePushInfoReply = protobuf.Message(ChargePushModule_pb.GETCHARGEPUSHINFOREPLY_MSG)
ChargePushModule_pb.GetChargePushInfoRequest = protobuf.Message(ChargePushModule_pb.GETCHARGEPUSHINFOREQUEST_MSG)
ChargePushModule_pb.GetChargePushPush = protobuf.Message(ChargePushModule_pb.GETCHARGEPUSHPUSH_MSG)
ChargePushModule_pb.RecordChargePushReply = protobuf.Message(ChargePushModule_pb.RECORDCHARGEPUSHREPLY_MSG)
ChargePushModule_pb.RecordChargePushRequest = protobuf.Message(ChargePushModule_pb.RECORDCHARGEPUSHREQUEST_MSG)

return ChargePushModule_pb
