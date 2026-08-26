-- chunkname: @modules/proto/Activity159Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity159Module_pb", package.seeall)

local Activity159Module_pb = {}

Activity159Module_pb.GET159BONUSREPLY_MSG = protobuf.Descriptor()
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity159Module_pb.GET159BONUSREQUEST_MSG = protobuf.Descriptor()
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity159Module_pb.GET159INFOSREQUEST_MSG = protobuf.Descriptor()
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity159Module_pb.GET159INFOSREPLY_MSG = protobuf.Descriptor()
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD = protobuf.FieldDescriptor()
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD = protobuf.FieldDescriptor()
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.full_name = ".Get159BonusReply.activityId"
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.number = 1
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.index = 0
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.label = 1
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.type = 5
Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity159Module_pb.GET159BONUSREPLY_MSG.name = "Get159BonusReply"
Activity159Module_pb.GET159BONUSREPLY_MSG.full_name = ".Get159BonusReply"
Activity159Module_pb.GET159BONUSREPLY_MSG.nested_types = {}
Activity159Module_pb.GET159BONUSREPLY_MSG.enum_types = {}
Activity159Module_pb.GET159BONUSREPLY_MSG.fields = {
	Activity159Module_pb.GET159BONUSREPLYACTIVITYIDFIELD
}
Activity159Module_pb.GET159BONUSREPLY_MSG.is_extendable = false
Activity159Module_pb.GET159BONUSREPLY_MSG.extensions = {}
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.full_name = ".Get159BonusRequest.activityId"
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity159Module_pb.GET159BONUSREQUEST_MSG.name = "Get159BonusRequest"
Activity159Module_pb.GET159BONUSREQUEST_MSG.full_name = ".Get159BonusRequest"
Activity159Module_pb.GET159BONUSREQUEST_MSG.nested_types = {}
Activity159Module_pb.GET159BONUSREQUEST_MSG.enum_types = {}
Activity159Module_pb.GET159BONUSREQUEST_MSG.fields = {
	Activity159Module_pb.GET159BONUSREQUESTACTIVITYIDFIELD
}
Activity159Module_pb.GET159BONUSREQUEST_MSG.is_extendable = false
Activity159Module_pb.GET159BONUSREQUEST_MSG.extensions = {}
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get159InfosRequest.activityId"
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity159Module_pb.GET159INFOSREQUEST_MSG.name = "Get159InfosRequest"
Activity159Module_pb.GET159INFOSREQUEST_MSG.full_name = ".Get159InfosRequest"
Activity159Module_pb.GET159INFOSREQUEST_MSG.nested_types = {}
Activity159Module_pb.GET159INFOSREQUEST_MSG.enum_types = {}
Activity159Module_pb.GET159INFOSREQUEST_MSG.fields = {
	Activity159Module_pb.GET159INFOSREQUESTACTIVITYIDFIELD
}
Activity159Module_pb.GET159INFOSREQUEST_MSG.is_extendable = false
Activity159Module_pb.GET159INFOSREQUEST_MSG.extensions = {}
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.full_name = ".Get159InfosReply.activityId"
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.number = 1
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.index = 0
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.label = 1
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.type = 5
Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.name = "currentDay"
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.full_name = ".Get159InfosReply.currentDay"
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.number = 2
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.index = 1
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.label = 1
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.has_default_value = false
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.default_value = 0
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.type = 5
Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD.cpp_type = 1
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.name = "hasGetBonus"
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.full_name = ".Get159InfosReply.hasGetBonus"
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.number = 3
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.index = 2
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.label = 1
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.has_default_value = false
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.default_value = false
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.type = 8
Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD.cpp_type = 7
Activity159Module_pb.GET159INFOSREPLY_MSG.name = "Get159InfosReply"
Activity159Module_pb.GET159INFOSREPLY_MSG.full_name = ".Get159InfosReply"
Activity159Module_pb.GET159INFOSREPLY_MSG.nested_types = {}
Activity159Module_pb.GET159INFOSREPLY_MSG.enum_types = {}
Activity159Module_pb.GET159INFOSREPLY_MSG.fields = {
	Activity159Module_pb.GET159INFOSREPLYACTIVITYIDFIELD,
	Activity159Module_pb.GET159INFOSREPLYCURRENTDAYFIELD,
	Activity159Module_pb.GET159INFOSREPLYHASGETBONUSFIELD
}
Activity159Module_pb.GET159INFOSREPLY_MSG.is_extendable = false
Activity159Module_pb.GET159INFOSREPLY_MSG.extensions = {}
Activity159Module_pb.Get159BonusReply = protobuf.Message(Activity159Module_pb.GET159BONUSREPLY_MSG)
Activity159Module_pb.Get159BonusRequest = protobuf.Message(Activity159Module_pb.GET159BONUSREQUEST_MSG)
Activity159Module_pb.Get159InfosReply = protobuf.Message(Activity159Module_pb.GET159INFOSREPLY_MSG)
Activity159Module_pb.Get159InfosRequest = protobuf.Message(Activity159Module_pb.GET159INFOSREQUEST_MSG)

return Activity159Module_pb
