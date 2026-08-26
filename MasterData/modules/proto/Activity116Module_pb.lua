-- chunkname: @modules/proto/Activity116Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity116Module_pb", package.seeall)

local Activity116Module_pb = {}

Activity116Module_pb.DUNGEONDEF_PB = require("modules.proto.DungeonDef_pb")
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG = protobuf.Descriptor()
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG = protobuf.Descriptor()
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG = protobuf.Descriptor()
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.PUTTRAPREPLY_MSG = protobuf.Descriptor()
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.GET116INFOSREPLY_MSG = protobuf.Descriptor()
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.BUILDTRAPREQUEST_MSG = protobuf.Descriptor()
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.PUTTRAPREQUEST_MSG = protobuf.Descriptor()
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFO_MSG = protobuf.Descriptor()
Activity116Module_pb.ACT116INFOELEMENTIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFOLEVELFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.GET116INFOSREQUEST_MSG = protobuf.Descriptor()
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.BUILDTRAPREPLY_MSG = protobuf.Descriptor()
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD = protobuf.FieldDescriptor()
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.full_name = ".Act116InfoUpdatePush.activityId"
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.number = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.index = 0
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.label = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.type = 5
Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.name = "infos"
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.full_name = ".Act116InfoUpdatePush.infos"
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.number = 2
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.index = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.label = 3
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.default_value = {}
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.message_type = Activity116Module_pb.ACT116INFO_MSG
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.type = 11
Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD.cpp_type = 10
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.name = "trapIds"
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.full_name = ".Act116InfoUpdatePush.trapIds"
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.number = 3
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.index = 2
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.label = 3
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.default_value = {}
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.type = 5
Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD.cpp_type = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.name = "putTrap"
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.full_name = ".Act116InfoUpdatePush.putTrap"
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.number = 4
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.index = 3
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.label = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.default_value = 0
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.type = 5
Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD.cpp_type = 1
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.name = "spStatus"
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.full_name = ".Act116InfoUpdatePush.spStatus"
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.number = 5
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.index = 4
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.label = 3
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.default_value = {}
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.message_type = Activity116Module_pb.DUNGEONDEF_PB.USERDUNGEONSPSTATUS_MSG
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.type = 11
Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD.cpp_type = 10
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.name = "Act116InfoUpdatePush"
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.full_name = ".Act116InfoUpdatePush"
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.nested_types = {}
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.enum_types = {}
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.fields = {
	Activity116Module_pb.ACT116INFOUPDATEPUSHACTIVITYIDFIELD,
	Activity116Module_pb.ACT116INFOUPDATEPUSHINFOSFIELD,
	Activity116Module_pb.ACT116INFOUPDATEPUSHTRAPIDSFIELD,
	Activity116Module_pb.ACT116INFOUPDATEPUSHPUTTRAPFIELD,
	Activity116Module_pb.ACT116INFOUPDATEPUSHSPSTATUSFIELD
}
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.is_extendable = false
Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG.extensions = {}
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.full_name = ".UpgradeElementRequest.activityId"
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.number = 1
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.index = 0
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.label = 1
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.type = 5
Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.name = "elementId"
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.full_name = ".UpgradeElementRequest.elementId"
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.number = 2
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.index = 1
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.label = 1
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.has_default_value = false
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.default_value = 0
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.type = 5
Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD.cpp_type = 1
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.name = "UpgradeElementRequest"
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.full_name = ".UpgradeElementRequest"
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.nested_types = {}
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.enum_types = {}
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.fields = {
	Activity116Module_pb.UPGRADEELEMENTREQUESTACTIVITYIDFIELD,
	Activity116Module_pb.UPGRADEELEMENTREQUESTELEMENTIDFIELD
}
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.is_extendable = false
Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG.extensions = {}
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.full_name = ".UpgradeElementReply.activityId"
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.number = 1
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.index = 0
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.label = 1
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.type = 5
Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.name = "elementId"
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.full_name = ".UpgradeElementReply.elementId"
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.number = 2
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.index = 1
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.label = 1
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.has_default_value = false
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.default_value = 0
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.type = 5
Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD.cpp_type = 1
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.name = "level"
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.full_name = ".UpgradeElementReply.level"
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.number = 3
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.index = 2
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.label = 1
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.has_default_value = false
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.default_value = 0
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.type = 5
Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD.cpp_type = 1
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.name = "UpgradeElementReply"
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.full_name = ".UpgradeElementReply"
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.nested_types = {}
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.enum_types = {}
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.fields = {
	Activity116Module_pb.UPGRADEELEMENTREPLYACTIVITYIDFIELD,
	Activity116Module_pb.UPGRADEELEMENTREPLYELEMENTIDFIELD,
	Activity116Module_pb.UPGRADEELEMENTREPLYLEVELFIELD
}
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.is_extendable = false
Activity116Module_pb.UPGRADEELEMENTREPLY_MSG.extensions = {}
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.full_name = ".PutTrapReply.activityId"
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.number = 1
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.index = 0
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.label = 1
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.type = 5
Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.name = "trapId"
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.full_name = ".PutTrapReply.trapId"
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.number = 2
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.index = 1
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.label = 1
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.has_default_value = false
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.default_value = 0
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.type = 5
Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD.cpp_type = 1
Activity116Module_pb.PUTTRAPREPLY_MSG.name = "PutTrapReply"
Activity116Module_pb.PUTTRAPREPLY_MSG.full_name = ".PutTrapReply"
Activity116Module_pb.PUTTRAPREPLY_MSG.nested_types = {}
Activity116Module_pb.PUTTRAPREPLY_MSG.enum_types = {}
Activity116Module_pb.PUTTRAPREPLY_MSG.fields = {
	Activity116Module_pb.PUTTRAPREPLYACTIVITYIDFIELD,
	Activity116Module_pb.PUTTRAPREPLYTRAPIDFIELD
}
Activity116Module_pb.PUTTRAPREPLY_MSG.is_extendable = false
Activity116Module_pb.PUTTRAPREPLY_MSG.extensions = {}
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.full_name = ".Get116InfosReply.activityId"
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.number = 1
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.index = 0
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.label = 1
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.type = 5
Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.name = "infos"
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.full_name = ".Get116InfosReply.infos"
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.number = 2
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.index = 1
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.label = 3
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.has_default_value = false
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.default_value = {}
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.message_type = Activity116Module_pb.ACT116INFO_MSG
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.type = 11
Activity116Module_pb.GET116INFOSREPLYINFOSFIELD.cpp_type = 10
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.name = "trapIds"
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.full_name = ".Get116InfosReply.trapIds"
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.number = 3
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.index = 2
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.label = 3
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.has_default_value = false
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.default_value = {}
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.type = 5
Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD.cpp_type = 1
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.name = "putTrap"
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.full_name = ".Get116InfosReply.putTrap"
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.number = 4
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.index = 3
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.label = 1
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.has_default_value = false
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.default_value = 0
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.type = 5
Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD.cpp_type = 1
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.name = "spStatus"
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.full_name = ".Get116InfosReply.spStatus"
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.number = 5
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.index = 4
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.label = 3
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.has_default_value = false
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.default_value = {}
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.message_type = Activity116Module_pb.DUNGEONDEF_PB.USERDUNGEONSPSTATUS_MSG
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.type = 11
Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD.cpp_type = 10
Activity116Module_pb.GET116INFOSREPLY_MSG.name = "Get116InfosReply"
Activity116Module_pb.GET116INFOSREPLY_MSG.full_name = ".Get116InfosReply"
Activity116Module_pb.GET116INFOSREPLY_MSG.nested_types = {}
Activity116Module_pb.GET116INFOSREPLY_MSG.enum_types = {}
Activity116Module_pb.GET116INFOSREPLY_MSG.fields = {
	Activity116Module_pb.GET116INFOSREPLYACTIVITYIDFIELD,
	Activity116Module_pb.GET116INFOSREPLYINFOSFIELD,
	Activity116Module_pb.GET116INFOSREPLYTRAPIDSFIELD,
	Activity116Module_pb.GET116INFOSREPLYPUTTRAPFIELD,
	Activity116Module_pb.GET116INFOSREPLYSPSTATUSFIELD
}
Activity116Module_pb.GET116INFOSREPLY_MSG.is_extendable = false
Activity116Module_pb.GET116INFOSREPLY_MSG.extensions = {}
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.full_name = ".BuildTrapRequest.activityId"
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.number = 1
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.index = 0
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.label = 1
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.type = 5
Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.name = "trapId"
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.full_name = ".BuildTrapRequest.trapId"
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.number = 2
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.index = 1
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.label = 1
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.has_default_value = false
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.default_value = 0
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.type = 5
Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD.cpp_type = 1
Activity116Module_pb.BUILDTRAPREQUEST_MSG.name = "BuildTrapRequest"
Activity116Module_pb.BUILDTRAPREQUEST_MSG.full_name = ".BuildTrapRequest"
Activity116Module_pb.BUILDTRAPREQUEST_MSG.nested_types = {}
Activity116Module_pb.BUILDTRAPREQUEST_MSG.enum_types = {}
Activity116Module_pb.BUILDTRAPREQUEST_MSG.fields = {
	Activity116Module_pb.BUILDTRAPREQUESTACTIVITYIDFIELD,
	Activity116Module_pb.BUILDTRAPREQUESTTRAPIDFIELD
}
Activity116Module_pb.BUILDTRAPREQUEST_MSG.is_extendable = false
Activity116Module_pb.BUILDTRAPREQUEST_MSG.extensions = {}
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.full_name = ".PutTrapRequest.activityId"
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.number = 1
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.index = 0
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.label = 1
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.type = 5
Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.name = "trapId"
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.full_name = ".PutTrapRequest.trapId"
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.number = 2
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.index = 1
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.label = 1
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.has_default_value = false
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.default_value = 0
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.type = 5
Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD.cpp_type = 1
Activity116Module_pb.PUTTRAPREQUEST_MSG.name = "PutTrapRequest"
Activity116Module_pb.PUTTRAPREQUEST_MSG.full_name = ".PutTrapRequest"
Activity116Module_pb.PUTTRAPREQUEST_MSG.nested_types = {}
Activity116Module_pb.PUTTRAPREQUEST_MSG.enum_types = {}
Activity116Module_pb.PUTTRAPREQUEST_MSG.fields = {
	Activity116Module_pb.PUTTRAPREQUESTACTIVITYIDFIELD,
	Activity116Module_pb.PUTTRAPREQUESTTRAPIDFIELD
}
Activity116Module_pb.PUTTRAPREQUEST_MSG.is_extendable = false
Activity116Module_pb.PUTTRAPREQUEST_MSG.extensions = {}
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.name = "elementId"
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.full_name = ".Act116Info.elementId"
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.number = 1
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.index = 0
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.label = 1
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.default_value = 0
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.type = 5
Activity116Module_pb.ACT116INFOELEMENTIDFIELD.cpp_type = 1
Activity116Module_pb.ACT116INFOLEVELFIELD.name = "level"
Activity116Module_pb.ACT116INFOLEVELFIELD.full_name = ".Act116Info.level"
Activity116Module_pb.ACT116INFOLEVELFIELD.number = 2
Activity116Module_pb.ACT116INFOLEVELFIELD.index = 1
Activity116Module_pb.ACT116INFOLEVELFIELD.label = 1
Activity116Module_pb.ACT116INFOLEVELFIELD.has_default_value = false
Activity116Module_pb.ACT116INFOLEVELFIELD.default_value = 0
Activity116Module_pb.ACT116INFOLEVELFIELD.type = 5
Activity116Module_pb.ACT116INFOLEVELFIELD.cpp_type = 1
Activity116Module_pb.ACT116INFO_MSG.name = "Act116Info"
Activity116Module_pb.ACT116INFO_MSG.full_name = ".Act116Info"
Activity116Module_pb.ACT116INFO_MSG.nested_types = {}
Activity116Module_pb.ACT116INFO_MSG.enum_types = {}
Activity116Module_pb.ACT116INFO_MSG.fields = {
	Activity116Module_pb.ACT116INFOELEMENTIDFIELD,
	Activity116Module_pb.ACT116INFOLEVELFIELD
}
Activity116Module_pb.ACT116INFO_MSG.is_extendable = false
Activity116Module_pb.ACT116INFO_MSG.extensions = {}
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get116InfosRequest.activityId"
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.GET116INFOSREQUEST_MSG.name = "Get116InfosRequest"
Activity116Module_pb.GET116INFOSREQUEST_MSG.full_name = ".Get116InfosRequest"
Activity116Module_pb.GET116INFOSREQUEST_MSG.nested_types = {}
Activity116Module_pb.GET116INFOSREQUEST_MSG.enum_types = {}
Activity116Module_pb.GET116INFOSREQUEST_MSG.fields = {
	Activity116Module_pb.GET116INFOSREQUESTACTIVITYIDFIELD
}
Activity116Module_pb.GET116INFOSREQUEST_MSG.is_extendable = false
Activity116Module_pb.GET116INFOSREQUEST_MSG.extensions = {}
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.name = "activityId"
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.full_name = ".BuildTrapReply.activityId"
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.number = 1
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.index = 0
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.label = 1
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.has_default_value = false
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.default_value = 0
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.type = 5
Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD.cpp_type = 1
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.name = "trapId"
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.full_name = ".BuildTrapReply.trapId"
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.number = 2
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.index = 1
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.label = 1
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.has_default_value = false
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.default_value = 0
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.type = 5
Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD.cpp_type = 1
Activity116Module_pb.BUILDTRAPREPLY_MSG.name = "BuildTrapReply"
Activity116Module_pb.BUILDTRAPREPLY_MSG.full_name = ".BuildTrapReply"
Activity116Module_pb.BUILDTRAPREPLY_MSG.nested_types = {}
Activity116Module_pb.BUILDTRAPREPLY_MSG.enum_types = {}
Activity116Module_pb.BUILDTRAPREPLY_MSG.fields = {
	Activity116Module_pb.BUILDTRAPREPLYACTIVITYIDFIELD,
	Activity116Module_pb.BUILDTRAPREPLYTRAPIDFIELD
}
Activity116Module_pb.BUILDTRAPREPLY_MSG.is_extendable = false
Activity116Module_pb.BUILDTRAPREPLY_MSG.extensions = {}
Activity116Module_pb.Act116Info = protobuf.Message(Activity116Module_pb.ACT116INFO_MSG)
Activity116Module_pb.Act116InfoUpdatePush = protobuf.Message(Activity116Module_pb.ACT116INFOUPDATEPUSH_MSG)
Activity116Module_pb.BuildTrapReply = protobuf.Message(Activity116Module_pb.BUILDTRAPREPLY_MSG)
Activity116Module_pb.BuildTrapRequest = protobuf.Message(Activity116Module_pb.BUILDTRAPREQUEST_MSG)
Activity116Module_pb.Get116InfosReply = protobuf.Message(Activity116Module_pb.GET116INFOSREPLY_MSG)
Activity116Module_pb.Get116InfosRequest = protobuf.Message(Activity116Module_pb.GET116INFOSREQUEST_MSG)
Activity116Module_pb.PutTrapReply = protobuf.Message(Activity116Module_pb.PUTTRAPREPLY_MSG)
Activity116Module_pb.PutTrapRequest = protobuf.Message(Activity116Module_pb.PUTTRAPREQUEST_MSG)
Activity116Module_pb.UpgradeElementReply = protobuf.Message(Activity116Module_pb.UPGRADEELEMENTREPLY_MSG)
Activity116Module_pb.UpgradeElementRequest = protobuf.Message(Activity116Module_pb.UPGRADEELEMENTREQUEST_MSG)

return Activity116Module_pb
