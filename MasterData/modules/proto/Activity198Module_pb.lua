-- chunkname: @modules/proto/Activity198Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity198Module_pb", package.seeall)

local Activity198Module_pb = {}

Activity198Module_pb.ACT198GAINREQUEST_MSG = protobuf.Descriptor()
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity198Module_pb.ACT198CANGETPUSH_MSG = protobuf.Descriptor()
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity198Module_pb.ACT198GAINREPLY_MSG = protobuf.Descriptor()
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.name = "activityId"
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.full_name = ".Act198GainRequest.activityId"
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.number = 1
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.index = 0
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.label = 1
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.has_default_value = false
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.default_value = 0
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.type = 5
Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity198Module_pb.ACT198GAINREQUEST_MSG.name = "Act198GainRequest"
Activity198Module_pb.ACT198GAINREQUEST_MSG.full_name = ".Act198GainRequest"
Activity198Module_pb.ACT198GAINREQUEST_MSG.nested_types = {}
Activity198Module_pb.ACT198GAINREQUEST_MSG.enum_types = {}
Activity198Module_pb.ACT198GAINREQUEST_MSG.fields = {
	Activity198Module_pb.ACT198GAINREQUESTACTIVITYIDFIELD
}
Activity198Module_pb.ACT198GAINREQUEST_MSG.is_extendable = false
Activity198Module_pb.ACT198GAINREQUEST_MSG.extensions = {}
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.name = "activityId"
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.full_name = ".Act198CanGetPush.activityId"
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.number = 1
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.index = 0
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.label = 1
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.has_default_value = false
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.default_value = 0
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.type = 5
Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD.cpp_type = 1
Activity198Module_pb.ACT198CANGETPUSH_MSG.name = "Act198CanGetPush"
Activity198Module_pb.ACT198CANGETPUSH_MSG.full_name = ".Act198CanGetPush"
Activity198Module_pb.ACT198CANGETPUSH_MSG.nested_types = {}
Activity198Module_pb.ACT198CANGETPUSH_MSG.enum_types = {}
Activity198Module_pb.ACT198CANGETPUSH_MSG.fields = {
	Activity198Module_pb.ACT198CANGETPUSHACTIVITYIDFIELD
}
Activity198Module_pb.ACT198CANGETPUSH_MSG.is_extendable = false
Activity198Module_pb.ACT198CANGETPUSH_MSG.extensions = {}
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.name = "activityId"
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.full_name = ".Act198GainReply.activityId"
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.number = 1
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.index = 0
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.label = 1
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.has_default_value = false
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.default_value = 0
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.type = 5
Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD.cpp_type = 1
Activity198Module_pb.ACT198GAINREPLY_MSG.name = "Act198GainReply"
Activity198Module_pb.ACT198GAINREPLY_MSG.full_name = ".Act198GainReply"
Activity198Module_pb.ACT198GAINREPLY_MSG.nested_types = {}
Activity198Module_pb.ACT198GAINREPLY_MSG.enum_types = {}
Activity198Module_pb.ACT198GAINREPLY_MSG.fields = {
	Activity198Module_pb.ACT198GAINREPLYACTIVITYIDFIELD
}
Activity198Module_pb.ACT198GAINREPLY_MSG.is_extendable = false
Activity198Module_pb.ACT198GAINREPLY_MSG.extensions = {}
Activity198Module_pb.Act198CanGetPush = protobuf.Message(Activity198Module_pb.ACT198CANGETPUSH_MSG)
Activity198Module_pb.Act198GainReply = protobuf.Message(Activity198Module_pb.ACT198GAINREPLY_MSG)
Activity198Module_pb.Act198GainRequest = protobuf.Message(Activity198Module_pb.ACT198GAINREQUEST_MSG)

return Activity198Module_pb
