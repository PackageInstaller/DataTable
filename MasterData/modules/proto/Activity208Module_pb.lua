-- chunkname: @modules/proto/Activity208Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity208Module_pb", package.seeall)

local Activity208Module_pb = {}

Activity208Module_pb.GETACT208INFOREPLY_MSG = protobuf.Descriptor()
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG = protobuf.Descriptor()
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.ACT208BONUSNO_MSG = protobuf.Descriptor()
Activity208Module_pb.ACT208BONUSNOIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.GETACT208INFOREQUEST_MSG = protobuf.Descriptor()
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG = protobuf.Descriptor()
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct208InfoReply.activityId"
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.number = 1
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.index = 0
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.label = 1
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.type = 5
Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.name = "bonus"
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.full_name = ".GetAct208InfoReply.bonus"
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.number = 2
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.index = 1
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.label = 3
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.has_default_value = false
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.default_value = {}
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.message_type = Activity208Module_pb.ACT208BONUSNO_MSG
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.type = 11
Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD.cpp_type = 10
Activity208Module_pb.GETACT208INFOREPLY_MSG.name = "GetAct208InfoReply"
Activity208Module_pb.GETACT208INFOREPLY_MSG.full_name = ".GetAct208InfoReply"
Activity208Module_pb.GETACT208INFOREPLY_MSG.nested_types = {}
Activity208Module_pb.GETACT208INFOREPLY_MSG.enum_types = {}
Activity208Module_pb.GETACT208INFOREPLY_MSG.fields = {
	Activity208Module_pb.GETACT208INFOREPLYACTIVITYIDFIELD,
	Activity208Module_pb.GETACT208INFOREPLYBONUSFIELD
}
Activity208Module_pb.GETACT208INFOREPLY_MSG.is_extendable = false
Activity208Module_pb.GETACT208INFOREPLY_MSG.extensions = {}
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.full_name = ".Act208ReceiveBonusReply.activityId"
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.number = 1
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.index = 0
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.label = 1
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.type = 5
Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.name = "id"
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.full_name = ".Act208ReceiveBonusReply.id"
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.number = 2
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.index = 1
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.label = 1
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.has_default_value = false
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.default_value = 0
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.type = 5
Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD.cpp_type = 1
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.name = "Act208ReceiveBonusReply"
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.full_name = ".Act208ReceiveBonusReply"
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.nested_types = {}
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.enum_types = {}
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.fields = {
	Activity208Module_pb.ACT208RECEIVEBONUSREPLYACTIVITYIDFIELD,
	Activity208Module_pb.ACT208RECEIVEBONUSREPLYIDFIELD
}
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.is_extendable = false
Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG.extensions = {}
Activity208Module_pb.ACT208BONUSNOIDFIELD.name = "id"
Activity208Module_pb.ACT208BONUSNOIDFIELD.full_name = ".Act208BonusNO.id"
Activity208Module_pb.ACT208BONUSNOIDFIELD.number = 1
Activity208Module_pb.ACT208BONUSNOIDFIELD.index = 0
Activity208Module_pb.ACT208BONUSNOIDFIELD.label = 1
Activity208Module_pb.ACT208BONUSNOIDFIELD.has_default_value = false
Activity208Module_pb.ACT208BONUSNOIDFIELD.default_value = 0
Activity208Module_pb.ACT208BONUSNOIDFIELD.type = 5
Activity208Module_pb.ACT208BONUSNOIDFIELD.cpp_type = 1
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.name = "status"
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.full_name = ".Act208BonusNO.status"
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.number = 2
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.index = 1
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.label = 1
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.has_default_value = false
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.default_value = 0
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.type = 5
Activity208Module_pb.ACT208BONUSNOSTATUSFIELD.cpp_type = 1
Activity208Module_pb.ACT208BONUSNO_MSG.name = "Act208BonusNO"
Activity208Module_pb.ACT208BONUSNO_MSG.full_name = ".Act208BonusNO"
Activity208Module_pb.ACT208BONUSNO_MSG.nested_types = {}
Activity208Module_pb.ACT208BONUSNO_MSG.enum_types = {}
Activity208Module_pb.ACT208BONUSNO_MSG.fields = {
	Activity208Module_pb.ACT208BONUSNOIDFIELD,
	Activity208Module_pb.ACT208BONUSNOSTATUSFIELD
}
Activity208Module_pb.ACT208BONUSNO_MSG.is_extendable = false
Activity208Module_pb.ACT208BONUSNO_MSG.extensions = {}
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct208InfoRequest.activityId"
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.number = 1
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.index = 0
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.label = 1
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.type = 5
Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.name = "id"
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.full_name = ".GetAct208InfoRequest.id"
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.number = 2
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.index = 1
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.label = 1
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.has_default_value = false
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.default_value = 0
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.type = 5
Activity208Module_pb.GETACT208INFOREQUESTIDFIELD.cpp_type = 1
Activity208Module_pb.GETACT208INFOREQUEST_MSG.name = "GetAct208InfoRequest"
Activity208Module_pb.GETACT208INFOREQUEST_MSG.full_name = ".GetAct208InfoRequest"
Activity208Module_pb.GETACT208INFOREQUEST_MSG.nested_types = {}
Activity208Module_pb.GETACT208INFOREQUEST_MSG.enum_types = {}
Activity208Module_pb.GETACT208INFOREQUEST_MSG.fields = {
	Activity208Module_pb.GETACT208INFOREQUESTACTIVITYIDFIELD,
	Activity208Module_pb.GETACT208INFOREQUESTIDFIELD
}
Activity208Module_pb.GETACT208INFOREQUEST_MSG.is_extendable = false
Activity208Module_pb.GETACT208INFOREQUEST_MSG.extensions = {}
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.full_name = ".Act208ReceiveBonusRequest.activityId"
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.number = 1
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.index = 0
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.label = 1
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.type = 5
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.name = "id"
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.full_name = ".Act208ReceiveBonusRequest.id"
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.number = 2
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.index = 1
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.label = 1
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.has_default_value = false
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.default_value = 0
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.type = 5
Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD.cpp_type = 1
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.name = "Act208ReceiveBonusRequest"
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.full_name = ".Act208ReceiveBonusRequest"
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.nested_types = {}
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.enum_types = {}
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.fields = {
	Activity208Module_pb.ACT208RECEIVEBONUSREQUESTACTIVITYIDFIELD,
	Activity208Module_pb.ACT208RECEIVEBONUSREQUESTIDFIELD
}
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.is_extendable = false
Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG.extensions = {}
Activity208Module_pb.Act208BonusNO = protobuf.Message(Activity208Module_pb.ACT208BONUSNO_MSG)
Activity208Module_pb.Act208ReceiveBonusReply = protobuf.Message(Activity208Module_pb.ACT208RECEIVEBONUSREPLY_MSG)
Activity208Module_pb.Act208ReceiveBonusRequest = protobuf.Message(Activity208Module_pb.ACT208RECEIVEBONUSREQUEST_MSG)
Activity208Module_pb.GetAct208InfoReply = protobuf.Message(Activity208Module_pb.GETACT208INFOREPLY_MSG)
Activity208Module_pb.GetAct208InfoRequest = protobuf.Message(Activity208Module_pb.GETACT208INFOREQUEST_MSG)

return Activity208Module_pb
