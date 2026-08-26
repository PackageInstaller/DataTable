-- chunkname: @modules/proto/Activity212Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity212Module_pb", package.seeall)

local Activity212Module_pb = {}

Activity212Module_pb.ACT212BONUSNO_MSG = protobuf.Descriptor()
Activity212Module_pb.ACT212BONUSNOIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212INFONO_MSG = protobuf.Descriptor()
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212INFONOISACTIVEFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212INFONOBONUSSFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212INFONOENDTIMEFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG = protobuf.Descriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212BONUSPUSH_MSG = protobuf.Descriptor()
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.GETACT212INFOREQUEST_MSG = protobuf.Descriptor()
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG = protobuf.Descriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.GETACT212INFOREPLY_MSG = protobuf.Descriptor()
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD = protobuf.FieldDescriptor()
Activity212Module_pb.ACT212BONUSNOIDFIELD.name = "id"
Activity212Module_pb.ACT212BONUSNOIDFIELD.full_name = ".Act212BonusNO.id"
Activity212Module_pb.ACT212BONUSNOIDFIELD.number = 1
Activity212Module_pb.ACT212BONUSNOIDFIELD.index = 0
Activity212Module_pb.ACT212BONUSNOIDFIELD.label = 1
Activity212Module_pb.ACT212BONUSNOIDFIELD.has_default_value = false
Activity212Module_pb.ACT212BONUSNOIDFIELD.default_value = 0
Activity212Module_pb.ACT212BONUSNOIDFIELD.type = 5
Activity212Module_pb.ACT212BONUSNOIDFIELD.cpp_type = 1
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.name = "status"
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.full_name = ".Act212BonusNO.status"
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.number = 2
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.index = 1
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.label = 1
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.has_default_value = false
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.default_value = 0
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.type = 5
Activity212Module_pb.ACT212BONUSNOSTATUSFIELD.cpp_type = 1
Activity212Module_pb.ACT212BONUSNO_MSG.name = "Act212BonusNO"
Activity212Module_pb.ACT212BONUSNO_MSG.full_name = ".Act212BonusNO"
Activity212Module_pb.ACT212BONUSNO_MSG.nested_types = {}
Activity212Module_pb.ACT212BONUSNO_MSG.enum_types = {}
Activity212Module_pb.ACT212BONUSNO_MSG.fields = {
	Activity212Module_pb.ACT212BONUSNOIDFIELD,
	Activity212Module_pb.ACT212BONUSNOSTATUSFIELD
}
Activity212Module_pb.ACT212BONUSNO_MSG.is_extendable = false
Activity212Module_pb.ACT212BONUSNO_MSG.extensions = {}
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.name = "activityId"
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.full_name = ".Act212InfoNO.activityId"
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.number = 1
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.index = 0
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.label = 1
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.has_default_value = false
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.default_value = 0
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.type = 5
Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD.cpp_type = 1
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.name = "isActive"
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.full_name = ".Act212InfoNO.isActive"
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.number = 2
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.index = 1
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.label = 1
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.has_default_value = false
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.default_value = false
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.type = 8
Activity212Module_pb.ACT212INFONOISACTIVEFIELD.cpp_type = 7
Activity212Module_pb.ACT212INFONOBONUSSFIELD.name = "bonuss"
Activity212Module_pb.ACT212INFONOBONUSSFIELD.full_name = ".Act212InfoNO.bonuss"
Activity212Module_pb.ACT212INFONOBONUSSFIELD.number = 3
Activity212Module_pb.ACT212INFONOBONUSSFIELD.index = 2
Activity212Module_pb.ACT212INFONOBONUSSFIELD.label = 3
Activity212Module_pb.ACT212INFONOBONUSSFIELD.has_default_value = false
Activity212Module_pb.ACT212INFONOBONUSSFIELD.default_value = {}
Activity212Module_pb.ACT212INFONOBONUSSFIELD.message_type = Activity212Module_pb.ACT212BONUSNO_MSG
Activity212Module_pb.ACT212INFONOBONUSSFIELD.type = 11
Activity212Module_pb.ACT212INFONOBONUSSFIELD.cpp_type = 10
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.name = "endTime"
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.full_name = ".Act212InfoNO.endTime"
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.number = 4
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.index = 3
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.label = 1
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.has_default_value = false
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.default_value = 0
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.type = 3
Activity212Module_pb.ACT212INFONOENDTIMEFIELD.cpp_type = 2
Activity212Module_pb.ACT212INFONO_MSG.name = "Act212InfoNO"
Activity212Module_pb.ACT212INFONO_MSG.full_name = ".Act212InfoNO"
Activity212Module_pb.ACT212INFONO_MSG.nested_types = {}
Activity212Module_pb.ACT212INFONO_MSG.enum_types = {}
Activity212Module_pb.ACT212INFONO_MSG.fields = {
	Activity212Module_pb.ACT212INFONOACTIVITYIDFIELD,
	Activity212Module_pb.ACT212INFONOISACTIVEFIELD,
	Activity212Module_pb.ACT212INFONOBONUSSFIELD,
	Activity212Module_pb.ACT212INFONOENDTIMEFIELD
}
Activity212Module_pb.ACT212INFONO_MSG.is_extendable = false
Activity212Module_pb.ACT212INFONO_MSG.extensions = {}
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.full_name = ".Act212ReceiveBonusReply.activityId"
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.number = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.index = 0
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.label = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.type = 5
Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.name = "id"
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.full_name = ".Act212ReceiveBonusReply.id"
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.number = 2
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.index = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.label = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.has_default_value = false
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.default_value = 0
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.type = 5
Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD.cpp_type = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.name = "status"
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.full_name = ".Act212ReceiveBonusReply.status"
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.number = 3
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.index = 2
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.label = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.has_default_value = false
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.default_value = 0
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.type = 5
Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD.cpp_type = 1
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.name = "Act212ReceiveBonusReply"
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.full_name = ".Act212ReceiveBonusReply"
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.nested_types = {}
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.enum_types = {}
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.fields = {
	Activity212Module_pb.ACT212RECEIVEBONUSREPLYACTIVITYIDFIELD,
	Activity212Module_pb.ACT212RECEIVEBONUSREPLYIDFIELD,
	Activity212Module_pb.ACT212RECEIVEBONUSREPLYSTATUSFIELD
}
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.is_extendable = false
Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG.extensions = {}
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.name = "act212Info"
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.full_name = ".Act212BonusPush.act212Info"
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.number = 1
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.index = 0
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.label = 1
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.has_default_value = false
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.default_value = nil
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.message_type = Activity212Module_pb.ACT212INFONO_MSG
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.type = 11
Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD.cpp_type = 10
Activity212Module_pb.ACT212BONUSPUSH_MSG.name = "Act212BonusPush"
Activity212Module_pb.ACT212BONUSPUSH_MSG.full_name = ".Act212BonusPush"
Activity212Module_pb.ACT212BONUSPUSH_MSG.nested_types = {}
Activity212Module_pb.ACT212BONUSPUSH_MSG.enum_types = {}
Activity212Module_pb.ACT212BONUSPUSH_MSG.fields = {
	Activity212Module_pb.ACT212BONUSPUSHACT212INFOFIELD
}
Activity212Module_pb.ACT212BONUSPUSH_MSG.is_extendable = false
Activity212Module_pb.ACT212BONUSPUSH_MSG.extensions = {}
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct212InfoRequest.activityId"
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.number = 1
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.index = 0
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.label = 1
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.type = 5
Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity212Module_pb.GETACT212INFOREQUEST_MSG.name = "GetAct212InfoRequest"
Activity212Module_pb.GETACT212INFOREQUEST_MSG.full_name = ".GetAct212InfoRequest"
Activity212Module_pb.GETACT212INFOREQUEST_MSG.nested_types = {}
Activity212Module_pb.GETACT212INFOREQUEST_MSG.enum_types = {}
Activity212Module_pb.GETACT212INFOREQUEST_MSG.fields = {
	Activity212Module_pb.GETACT212INFOREQUESTACTIVITYIDFIELD
}
Activity212Module_pb.GETACT212INFOREQUEST_MSG.is_extendable = false
Activity212Module_pb.GETACT212INFOREQUEST_MSG.extensions = {}
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.full_name = ".Act212ReceiveBonusRequest.activityId"
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.number = 1
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.index = 0
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.label = 1
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.type = 5
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.name = "id"
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.full_name = ".Act212ReceiveBonusRequest.id"
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.number = 2
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.index = 1
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.label = 1
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.has_default_value = false
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.default_value = 0
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.type = 5
Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD.cpp_type = 1
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.name = "Act212ReceiveBonusRequest"
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.full_name = ".Act212ReceiveBonusRequest"
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.nested_types = {}
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.enum_types = {}
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.fields = {
	Activity212Module_pb.ACT212RECEIVEBONUSREQUESTACTIVITYIDFIELD,
	Activity212Module_pb.ACT212RECEIVEBONUSREQUESTIDFIELD
}
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.is_extendable = false
Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG.extensions = {}
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.name = "act212Info"
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.full_name = ".GetAct212InfoReply.act212Info"
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.number = 1
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.index = 0
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.label = 1
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.has_default_value = false
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.default_value = nil
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.message_type = Activity212Module_pb.ACT212INFONO_MSG
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.type = 11
Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD.cpp_type = 10
Activity212Module_pb.GETACT212INFOREPLY_MSG.name = "GetAct212InfoReply"
Activity212Module_pb.GETACT212INFOREPLY_MSG.full_name = ".GetAct212InfoReply"
Activity212Module_pb.GETACT212INFOREPLY_MSG.nested_types = {}
Activity212Module_pb.GETACT212INFOREPLY_MSG.enum_types = {}
Activity212Module_pb.GETACT212INFOREPLY_MSG.fields = {
	Activity212Module_pb.GETACT212INFOREPLYACT212INFOFIELD
}
Activity212Module_pb.GETACT212INFOREPLY_MSG.is_extendable = false
Activity212Module_pb.GETACT212INFOREPLY_MSG.extensions = {}
Activity212Module_pb.Act212BonusNO = protobuf.Message(Activity212Module_pb.ACT212BONUSNO_MSG)
Activity212Module_pb.Act212BonusPush = protobuf.Message(Activity212Module_pb.ACT212BONUSPUSH_MSG)
Activity212Module_pb.Act212InfoNO = protobuf.Message(Activity212Module_pb.ACT212INFONO_MSG)
Activity212Module_pb.Act212ReceiveBonusReply = protobuf.Message(Activity212Module_pb.ACT212RECEIVEBONUSREPLY_MSG)
Activity212Module_pb.Act212ReceiveBonusRequest = protobuf.Message(Activity212Module_pb.ACT212RECEIVEBONUSREQUEST_MSG)
Activity212Module_pb.GetAct212InfoReply = protobuf.Message(Activity212Module_pb.GETACT212INFOREPLY_MSG)
Activity212Module_pb.GetAct212InfoRequest = protobuf.Message(Activity212Module_pb.GETACT212INFOREQUEST_MSG)

return Activity212Module_pb
