-- chunkname: @modules/proto/Activity209Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity209Module_pb", package.seeall)

local Activity209Module_pb = {}

Activity209Module_pb.GETACT209INFOREQUEST_MSG = protobuf.Descriptor()
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity209Module_pb.ACT209INFOPUSH_MSG = protobuf.Descriptor()
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD = protobuf.FieldDescriptor()
Activity209Module_pb.GETACT209INFOREPLY_MSG = protobuf.Descriptor()
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD = protobuf.FieldDescriptor()
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct209InfoRequest.activityId"
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.number = 1
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.index = 0
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.label = 1
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.type = 5
Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity209Module_pb.GETACT209INFOREQUEST_MSG.name = "GetAct209InfoRequest"
Activity209Module_pb.GETACT209INFOREQUEST_MSG.full_name = ".GetAct209InfoRequest"
Activity209Module_pb.GETACT209INFOREQUEST_MSG.nested_types = {}
Activity209Module_pb.GETACT209INFOREQUEST_MSG.enum_types = {}
Activity209Module_pb.GETACT209INFOREQUEST_MSG.fields = {
	Activity209Module_pb.GETACT209INFOREQUESTACTIVITYIDFIELD
}
Activity209Module_pb.GETACT209INFOREQUEST_MSG.is_extendable = false
Activity209Module_pb.GETACT209INFOREQUEST_MSG.extensions = {}
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.name = "activityId"
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.full_name = ".Act209InfoPush.activityId"
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.number = 1
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.index = 0
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.label = 1
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.has_default_value = false
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.default_value = 0
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.type = 5
Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD.cpp_type = 1
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.name = "maxLayer"
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.full_name = ".Act209InfoPush.maxLayer"
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.number = 2
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.index = 1
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.label = 1
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.has_default_value = false
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.default_value = 0
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.type = 5
Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD.cpp_type = 1
Activity209Module_pb.ACT209INFOPUSH_MSG.name = "Act209InfoPush"
Activity209Module_pb.ACT209INFOPUSH_MSG.full_name = ".Act209InfoPush"
Activity209Module_pb.ACT209INFOPUSH_MSG.nested_types = {}
Activity209Module_pb.ACT209INFOPUSH_MSG.enum_types = {}
Activity209Module_pb.ACT209INFOPUSH_MSG.fields = {
	Activity209Module_pb.ACT209INFOPUSHACTIVITYIDFIELD,
	Activity209Module_pb.ACT209INFOPUSHMAXLAYERFIELD
}
Activity209Module_pb.ACT209INFOPUSH_MSG.is_extendable = false
Activity209Module_pb.ACT209INFOPUSH_MSG.extensions = {}
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct209InfoReply.activityId"
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.number = 1
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.index = 0
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.label = 1
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.type = 5
Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.name = "maxLayer"
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.full_name = ".GetAct209InfoReply.maxLayer"
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.number = 2
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.index = 1
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.label = 1
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.has_default_value = false
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.default_value = 0
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.type = 5
Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD.cpp_type = 1
Activity209Module_pb.GETACT209INFOREPLY_MSG.name = "GetAct209InfoReply"
Activity209Module_pb.GETACT209INFOREPLY_MSG.full_name = ".GetAct209InfoReply"
Activity209Module_pb.GETACT209INFOREPLY_MSG.nested_types = {}
Activity209Module_pb.GETACT209INFOREPLY_MSG.enum_types = {}
Activity209Module_pb.GETACT209INFOREPLY_MSG.fields = {
	Activity209Module_pb.GETACT209INFOREPLYACTIVITYIDFIELD,
	Activity209Module_pb.GETACT209INFOREPLYMAXLAYERFIELD
}
Activity209Module_pb.GETACT209INFOREPLY_MSG.is_extendable = false
Activity209Module_pb.GETACT209INFOREPLY_MSG.extensions = {}
Activity209Module_pb.Act209InfoPush = protobuf.Message(Activity209Module_pb.ACT209INFOPUSH_MSG)
Activity209Module_pb.GetAct209InfoReply = protobuf.Message(Activity209Module_pb.GETACT209INFOREPLY_MSG)
Activity209Module_pb.GetAct209InfoRequest = protobuf.Message(Activity209Module_pb.GETACT209INFOREQUEST_MSG)

return Activity209Module_pb
