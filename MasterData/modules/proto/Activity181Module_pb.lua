-- chunkname: @modules/proto/Activity181Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity181Module_pb", package.seeall)

local Activity181Module_pb = {}

Activity181Module_pb.GET181BONUSREQUEST_MSG = protobuf.Descriptor()
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181SPBONUSREQUEST_MSG = protobuf.Descriptor()
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181INFOSREPLY_MSG = protobuf.Descriptor()
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181INFOSREQUEST_MSG = protobuf.Descriptor()
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181SPBONUSREPLY_MSG = protobuf.Descriptor()
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.ACT181INFO_MSG = protobuf.Descriptor()
Activity181Module_pb.ACT181INFOPOSFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.ACT181INFOIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181BONUSREPLY_MSG = protobuf.Descriptor()
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181BONUSREPLYPOSFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181BONUSREPLYIDFIELD = protobuf.FieldDescriptor()
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.full_name = ".Get181BonusRequest.activityId"
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.name = "pos"
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.full_name = ".Get181BonusRequest.pos"
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.number = 2
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.index = 1
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.label = 1
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.has_default_value = false
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.default_value = 0
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.type = 5
Activity181Module_pb.GET181BONUSREQUESTPOSFIELD.cpp_type = 1
Activity181Module_pb.GET181BONUSREQUEST_MSG.name = "Get181BonusRequest"
Activity181Module_pb.GET181BONUSREQUEST_MSG.full_name = ".Get181BonusRequest"
Activity181Module_pb.GET181BONUSREQUEST_MSG.nested_types = {}
Activity181Module_pb.GET181BONUSREQUEST_MSG.enum_types = {}
Activity181Module_pb.GET181BONUSREQUEST_MSG.fields = {
	Activity181Module_pb.GET181BONUSREQUESTACTIVITYIDFIELD,
	Activity181Module_pb.GET181BONUSREQUESTPOSFIELD
}
Activity181Module_pb.GET181BONUSREQUEST_MSG.is_extendable = false
Activity181Module_pb.GET181BONUSREQUEST_MSG.extensions = {}
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.full_name = ".Get181SpBonusRequest.activityId"
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.number = 1
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.index = 0
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.label = 1
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.type = 5
Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.name = "Get181SpBonusRequest"
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.full_name = ".Get181SpBonusRequest"
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.nested_types = {}
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.enum_types = {}
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.fields = {
	Activity181Module_pb.GET181SPBONUSREQUESTACTIVITYIDFIELD
}
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.is_extendable = false
Activity181Module_pb.GET181SPBONUSREQUEST_MSG.extensions = {}
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.full_name = ".Get181InfosReply.activityId"
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.number = 1
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.index = 0
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.label = 1
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.type = 5
Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.name = "infos"
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.full_name = ".Get181InfosReply.infos"
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.number = 2
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.index = 1
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.label = 3
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.has_default_value = false
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.default_value = {}
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.message_type = Activity181Module_pb.ACT181INFO_MSG
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.type = 11
Activity181Module_pb.GET181INFOSREPLYINFOSFIELD.cpp_type = 10
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.name = "canGetTimes"
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.full_name = ".Get181InfosReply.canGetTimes"
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.number = 3
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.index = 2
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.label = 1
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.has_default_value = false
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.default_value = 0
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.type = 5
Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD.cpp_type = 1
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.name = "canGetSpBonus"
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.full_name = ".Get181InfosReply.canGetSpBonus"
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.number = 4
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.index = 3
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.label = 1
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.has_default_value = false
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.default_value = 0
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.type = 5
Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD.cpp_type = 1
Activity181Module_pb.GET181INFOSREPLY_MSG.name = "Get181InfosReply"
Activity181Module_pb.GET181INFOSREPLY_MSG.full_name = ".Get181InfosReply"
Activity181Module_pb.GET181INFOSREPLY_MSG.nested_types = {}
Activity181Module_pb.GET181INFOSREPLY_MSG.enum_types = {}
Activity181Module_pb.GET181INFOSREPLY_MSG.fields = {
	Activity181Module_pb.GET181INFOSREPLYACTIVITYIDFIELD,
	Activity181Module_pb.GET181INFOSREPLYINFOSFIELD,
	Activity181Module_pb.GET181INFOSREPLYCANGETTIMESFIELD,
	Activity181Module_pb.GET181INFOSREPLYCANGETSPBONUSFIELD
}
Activity181Module_pb.GET181INFOSREPLY_MSG.is_extendable = false
Activity181Module_pb.GET181INFOSREPLY_MSG.extensions = {}
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get181InfosRequest.activityId"
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity181Module_pb.GET181INFOSREQUEST_MSG.name = "Get181InfosRequest"
Activity181Module_pb.GET181INFOSREQUEST_MSG.full_name = ".Get181InfosRequest"
Activity181Module_pb.GET181INFOSREQUEST_MSG.nested_types = {}
Activity181Module_pb.GET181INFOSREQUEST_MSG.enum_types = {}
Activity181Module_pb.GET181INFOSREQUEST_MSG.fields = {
	Activity181Module_pb.GET181INFOSREQUESTACTIVITYIDFIELD
}
Activity181Module_pb.GET181INFOSREQUEST_MSG.is_extendable = false
Activity181Module_pb.GET181INFOSREQUEST_MSG.extensions = {}
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.full_name = ".Get181SpBonusReply.activityId"
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.number = 1
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.index = 0
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.label = 1
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.type = 5
Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity181Module_pb.GET181SPBONUSREPLY_MSG.name = "Get181SpBonusReply"
Activity181Module_pb.GET181SPBONUSREPLY_MSG.full_name = ".Get181SpBonusReply"
Activity181Module_pb.GET181SPBONUSREPLY_MSG.nested_types = {}
Activity181Module_pb.GET181SPBONUSREPLY_MSG.enum_types = {}
Activity181Module_pb.GET181SPBONUSREPLY_MSG.fields = {
	Activity181Module_pb.GET181SPBONUSREPLYACTIVITYIDFIELD
}
Activity181Module_pb.GET181SPBONUSREPLY_MSG.is_extendable = false
Activity181Module_pb.GET181SPBONUSREPLY_MSG.extensions = {}
Activity181Module_pb.ACT181INFOPOSFIELD.name = "pos"
Activity181Module_pb.ACT181INFOPOSFIELD.full_name = ".Act181Info.pos"
Activity181Module_pb.ACT181INFOPOSFIELD.number = 1
Activity181Module_pb.ACT181INFOPOSFIELD.index = 0
Activity181Module_pb.ACT181INFOPOSFIELD.label = 1
Activity181Module_pb.ACT181INFOPOSFIELD.has_default_value = false
Activity181Module_pb.ACT181INFOPOSFIELD.default_value = 0
Activity181Module_pb.ACT181INFOPOSFIELD.type = 13
Activity181Module_pb.ACT181INFOPOSFIELD.cpp_type = 3
Activity181Module_pb.ACT181INFOIDFIELD.name = "id"
Activity181Module_pb.ACT181INFOIDFIELD.full_name = ".Act181Info.id"
Activity181Module_pb.ACT181INFOIDFIELD.number = 2
Activity181Module_pb.ACT181INFOIDFIELD.index = 1
Activity181Module_pb.ACT181INFOIDFIELD.label = 1
Activity181Module_pb.ACT181INFOIDFIELD.has_default_value = false
Activity181Module_pb.ACT181INFOIDFIELD.default_value = 0
Activity181Module_pb.ACT181INFOIDFIELD.type = 13
Activity181Module_pb.ACT181INFOIDFIELD.cpp_type = 3
Activity181Module_pb.ACT181INFO_MSG.name = "Act181Info"
Activity181Module_pb.ACT181INFO_MSG.full_name = ".Act181Info"
Activity181Module_pb.ACT181INFO_MSG.nested_types = {}
Activity181Module_pb.ACT181INFO_MSG.enum_types = {}
Activity181Module_pb.ACT181INFO_MSG.fields = {
	Activity181Module_pb.ACT181INFOPOSFIELD,
	Activity181Module_pb.ACT181INFOIDFIELD
}
Activity181Module_pb.ACT181INFO_MSG.is_extendable = false
Activity181Module_pb.ACT181INFO_MSG.extensions = {}
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.full_name = ".Get181BonusReply.activityId"
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.number = 1
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.index = 0
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.label = 1
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.type = 5
Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.name = "pos"
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.full_name = ".Get181BonusReply.pos"
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.number = 2
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.index = 1
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.label = 1
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.has_default_value = false
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.default_value = 0
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.type = 5
Activity181Module_pb.GET181BONUSREPLYPOSFIELD.cpp_type = 1
Activity181Module_pb.GET181BONUSREPLYIDFIELD.name = "id"
Activity181Module_pb.GET181BONUSREPLYIDFIELD.full_name = ".Get181BonusReply.id"
Activity181Module_pb.GET181BONUSREPLYIDFIELD.number = 3
Activity181Module_pb.GET181BONUSREPLYIDFIELD.index = 2
Activity181Module_pb.GET181BONUSREPLYIDFIELD.label = 1
Activity181Module_pb.GET181BONUSREPLYIDFIELD.has_default_value = false
Activity181Module_pb.GET181BONUSREPLYIDFIELD.default_value = 0
Activity181Module_pb.GET181BONUSREPLYIDFIELD.type = 13
Activity181Module_pb.GET181BONUSREPLYIDFIELD.cpp_type = 3
Activity181Module_pb.GET181BONUSREPLY_MSG.name = "Get181BonusReply"
Activity181Module_pb.GET181BONUSREPLY_MSG.full_name = ".Get181BonusReply"
Activity181Module_pb.GET181BONUSREPLY_MSG.nested_types = {}
Activity181Module_pb.GET181BONUSREPLY_MSG.enum_types = {}
Activity181Module_pb.GET181BONUSREPLY_MSG.fields = {
	Activity181Module_pb.GET181BONUSREPLYACTIVITYIDFIELD,
	Activity181Module_pb.GET181BONUSREPLYPOSFIELD,
	Activity181Module_pb.GET181BONUSREPLYIDFIELD
}
Activity181Module_pb.GET181BONUSREPLY_MSG.is_extendable = false
Activity181Module_pb.GET181BONUSREPLY_MSG.extensions = {}
Activity181Module_pb.Act181Info = protobuf.Message(Activity181Module_pb.ACT181INFO_MSG)
Activity181Module_pb.Get181BonusReply = protobuf.Message(Activity181Module_pb.GET181BONUSREPLY_MSG)
Activity181Module_pb.Get181BonusRequest = protobuf.Message(Activity181Module_pb.GET181BONUSREQUEST_MSG)
Activity181Module_pb.Get181InfosReply = protobuf.Message(Activity181Module_pb.GET181INFOSREPLY_MSG)
Activity181Module_pb.Get181InfosRequest = protobuf.Message(Activity181Module_pb.GET181INFOSREQUEST_MSG)
Activity181Module_pb.Get181SpBonusReply = protobuf.Message(Activity181Module_pb.GET181SPBONUSREPLY_MSG)
Activity181Module_pb.Get181SpBonusRequest = protobuf.Message(Activity181Module_pb.GET181SPBONUSREQUEST_MSG)

return Activity181Module_pb
