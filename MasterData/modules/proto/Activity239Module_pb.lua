-- chunkname: @modules/proto/Activity239Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity239Module_pb", package.seeall)

local Activity239Module_pb = {}

Activity239Module_pb.ACT239BONUSNO_MSG = protobuf.Descriptor()
Activity239Module_pb.ACT239BONUSNOIDFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.ACT239BONUSREQUEST_MSG = protobuf.Descriptor()
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.GETACT239INFOREQUEST_MSG = protobuf.Descriptor()
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.GETACT239INFOREPLY_MSG = protobuf.Descriptor()
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.ACT239BONUSREPLY_MSG = protobuf.Descriptor()
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD = protobuf.FieldDescriptor()
Activity239Module_pb.ACT239BONUSNOIDFIELD.name = "id"
Activity239Module_pb.ACT239BONUSNOIDFIELD.full_name = ".Act239BonusNO.id"
Activity239Module_pb.ACT239BONUSNOIDFIELD.number = 1
Activity239Module_pb.ACT239BONUSNOIDFIELD.index = 0
Activity239Module_pb.ACT239BONUSNOIDFIELD.label = 1
Activity239Module_pb.ACT239BONUSNOIDFIELD.has_default_value = false
Activity239Module_pb.ACT239BONUSNOIDFIELD.default_value = 0
Activity239Module_pb.ACT239BONUSNOIDFIELD.type = 5
Activity239Module_pb.ACT239BONUSNOIDFIELD.cpp_type = 1
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.name = "status"
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.full_name = ".Act239BonusNO.status"
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.number = 2
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.index = 1
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.label = 1
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.has_default_value = false
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.default_value = 0
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.type = 5
Activity239Module_pb.ACT239BONUSNOSTATUSFIELD.cpp_type = 1
Activity239Module_pb.ACT239BONUSNO_MSG.name = "Act239BonusNO"
Activity239Module_pb.ACT239BONUSNO_MSG.full_name = ".Act239BonusNO"
Activity239Module_pb.ACT239BONUSNO_MSG.nested_types = {}
Activity239Module_pb.ACT239BONUSNO_MSG.enum_types = {}
Activity239Module_pb.ACT239BONUSNO_MSG.fields = {
	Activity239Module_pb.ACT239BONUSNOIDFIELD,
	Activity239Module_pb.ACT239BONUSNOSTATUSFIELD
}
Activity239Module_pb.ACT239BONUSNO_MSG.is_extendable = false
Activity239Module_pb.ACT239BONUSNO_MSG.extensions = {}
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.full_name = ".Act239BonusRequest.activityId"
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.name = "id"
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.full_name = ".Act239BonusRequest.id"
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.number = 2
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.index = 1
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.label = 1
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.has_default_value = false
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.default_value = 0
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.type = 5
Activity239Module_pb.ACT239BONUSREQUESTIDFIELD.cpp_type = 1
Activity239Module_pb.ACT239BONUSREQUEST_MSG.name = "Act239BonusRequest"
Activity239Module_pb.ACT239BONUSREQUEST_MSG.full_name = ".Act239BonusRequest"
Activity239Module_pb.ACT239BONUSREQUEST_MSG.nested_types = {}
Activity239Module_pb.ACT239BONUSREQUEST_MSG.enum_types = {}
Activity239Module_pb.ACT239BONUSREQUEST_MSG.fields = {
	Activity239Module_pb.ACT239BONUSREQUESTACTIVITYIDFIELD,
	Activity239Module_pb.ACT239BONUSREQUESTIDFIELD
}
Activity239Module_pb.ACT239BONUSREQUEST_MSG.is_extendable = false
Activity239Module_pb.ACT239BONUSREQUEST_MSG.extensions = {}
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct239InfoRequest.activityId"
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.number = 1
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.index = 0
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.label = 1
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.type = 5
Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity239Module_pb.GETACT239INFOREQUEST_MSG.name = "GetAct239InfoRequest"
Activity239Module_pb.GETACT239INFOREQUEST_MSG.full_name = ".GetAct239InfoRequest"
Activity239Module_pb.GETACT239INFOREQUEST_MSG.nested_types = {}
Activity239Module_pb.GETACT239INFOREQUEST_MSG.enum_types = {}
Activity239Module_pb.GETACT239INFOREQUEST_MSG.fields = {
	Activity239Module_pb.GETACT239INFOREQUESTACTIVITYIDFIELD
}
Activity239Module_pb.GETACT239INFOREQUEST_MSG.is_extendable = false
Activity239Module_pb.GETACT239INFOREQUEST_MSG.extensions = {}
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct239InfoReply.activityId"
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.number = 1
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.index = 0
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.label = 1
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.type = 5
Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.name = "bonuss"
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.full_name = ".GetAct239InfoReply.bonuss"
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.number = 2
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.index = 1
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.label = 3
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.has_default_value = false
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.default_value = {}
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.message_type = Activity239Module_pb.ACT239BONUSNO_MSG
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.type = 11
Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD.cpp_type = 10
Activity239Module_pb.GETACT239INFOREPLY_MSG.name = "GetAct239InfoReply"
Activity239Module_pb.GETACT239INFOREPLY_MSG.full_name = ".GetAct239InfoReply"
Activity239Module_pb.GETACT239INFOREPLY_MSG.nested_types = {}
Activity239Module_pb.GETACT239INFOREPLY_MSG.enum_types = {}
Activity239Module_pb.GETACT239INFOREPLY_MSG.fields = {
	Activity239Module_pb.GETACT239INFOREPLYACTIVITYIDFIELD,
	Activity239Module_pb.GETACT239INFOREPLYBONUSSFIELD
}
Activity239Module_pb.GETACT239INFOREPLY_MSG.is_extendable = false
Activity239Module_pb.GETACT239INFOREPLY_MSG.extensions = {}
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.full_name = ".Act239BonusReply.activityId"
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.number = 1
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.index = 0
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.label = 1
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.type = 5
Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.name = "bonuss"
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.full_name = ".Act239BonusReply.bonuss"
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.number = 2
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.index = 1
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.label = 3
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.has_default_value = false
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.default_value = {}
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.message_type = Activity239Module_pb.ACT239BONUSNO_MSG
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.type = 11
Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD.cpp_type = 10
Activity239Module_pb.ACT239BONUSREPLY_MSG.name = "Act239BonusReply"
Activity239Module_pb.ACT239BONUSREPLY_MSG.full_name = ".Act239BonusReply"
Activity239Module_pb.ACT239BONUSREPLY_MSG.nested_types = {}
Activity239Module_pb.ACT239BONUSREPLY_MSG.enum_types = {}
Activity239Module_pb.ACT239BONUSREPLY_MSG.fields = {
	Activity239Module_pb.ACT239BONUSREPLYACTIVITYIDFIELD,
	Activity239Module_pb.ACT239BONUSREPLYBONUSSFIELD
}
Activity239Module_pb.ACT239BONUSREPLY_MSG.is_extendable = false
Activity239Module_pb.ACT239BONUSREPLY_MSG.extensions = {}
Activity239Module_pb.Act239BonusNO = protobuf.Message(Activity239Module_pb.ACT239BONUSNO_MSG)
Activity239Module_pb.Act239BonusReply = protobuf.Message(Activity239Module_pb.ACT239BONUSREPLY_MSG)
Activity239Module_pb.Act239BonusRequest = protobuf.Message(Activity239Module_pb.ACT239BONUSREQUEST_MSG)
Activity239Module_pb.GetAct239InfoReply = protobuf.Message(Activity239Module_pb.GETACT239INFOREPLY_MSG)
Activity239Module_pb.GetAct239InfoRequest = protobuf.Message(Activity239Module_pb.GETACT239INFOREQUEST_MSG)

return Activity239Module_pb
