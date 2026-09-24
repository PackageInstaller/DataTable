-- chunkname: @modules/proto/RoleBadgeModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.RoleBadgeModule_pb", package.seeall)

local RoleBadgeModule_pb = {}

RoleBadgeModule_pb.ROLEBADGERECORD_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEINFO_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGE_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEIDFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD = protobuf.FieldDescriptor()
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG = protobuf.Descriptor()
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.name = "heroUid"
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.full_name = ".RoleBadgeRecord.heroUid"
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.type = 3
RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD.cpp_type = 2
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.name = "badges"
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.full_name = ".RoleBadgeRecord.badges"
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.number = 2
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.index = 1
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.label = 3
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.default_value = {}
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.message_type = RoleBadgeModule_pb.ROLEBADGE_MSG
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.name = "wears"
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.full_name = ".RoleBadgeRecord.wears"
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.number = 3
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.index = 2
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.label = 3
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.default_value = {}
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.message_type = RoleBadgeModule_pb.ROLEBADGEWEAR_MSG
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.name = "RoleBadgeRecord"
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.full_name = ".RoleBadgeRecord"
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGERECORDHEROUIDFIELD,
	RoleBadgeModule_pb.ROLEBADGERECORDBADGESFIELD,
	RoleBadgeModule_pb.ROLEBADGERECORDWEARSFIELD
}
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGERECORD_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.name = "info"
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.full_name = ".RoleBadgeGetInfoReply.info"
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.default_value = nil
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.message_type = RoleBadgeModule_pb.ROLEBADGEINFO_MSG
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.name = "RoleBadgeGetInfoReply"
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.full_name = ".RoleBadgeGetInfoReply"
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEGETINFOREPLYINFOFIELD
}
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.name = "records"
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.full_name = ".RoleBadgeUpdatePush.records"
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.label = 3
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.default_value = {}
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.message_type = RoleBadgeModule_pb.ROLEBADGERECORD_MSG
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.name = "RoleBadgeUpdatePush"
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.full_name = ".RoleBadgeUpdatePush"
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEUPDATEPUSHRECORDSFIELD
}
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.name = "records"
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.full_name = ".RoleBadgeInfo.records"
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.label = 3
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.default_value = {}
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.message_type = RoleBadgeModule_pb.ROLEBADGERECORD_MSG
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.name = "RoleBadgeInfo"
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.full_name = ".RoleBadgeInfo"
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEINFORECORDSFIELD
}
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEINFO_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEIDFIELD.name = "id"
RoleBadgeModule_pb.ROLEBADGEIDFIELD.full_name = ".RoleBadge.id"
RoleBadgeModule_pb.ROLEBADGEIDFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEIDFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEIDFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEIDFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEIDFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGEIDFIELD.type = 5
RoleBadgeModule_pb.ROLEBADGEIDFIELD.cpp_type = 1
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.name = "progress"
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.full_name = ".RoleBadge.progress"
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.number = 2
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.index = 1
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.type = 5
RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD.cpp_type = 1
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.name = "status"
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.full_name = ".RoleBadge.status"
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.number = 3
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.index = 2
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.type = 5
RoleBadgeModule_pb.ROLEBADGESTATUSFIELD.cpp_type = 1
RoleBadgeModule_pb.ROLEBADGE_MSG.name = "RoleBadge"
RoleBadgeModule_pb.ROLEBADGE_MSG.full_name = ".RoleBadge"
RoleBadgeModule_pb.ROLEBADGE_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGE_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGE_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEIDFIELD,
	RoleBadgeModule_pb.ROLEBADGEPROGRESSFIELD,
	RoleBadgeModule_pb.ROLEBADGESTATUSFIELD
}
RoleBadgeModule_pb.ROLEBADGE_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGE_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.name = "heroUid"
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.full_name = ".RoleBadgeWearRequest.heroUid"
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.type = 3
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD.cpp_type = 2
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.name = "wear"
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.full_name = ".RoleBadgeWearRequest.wear"
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.number = 2
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.index = 1
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.default_value = nil
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.message_type = RoleBadgeModule_pb.ROLEBADGEWEAR_MSG
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.name = "RoleBadgeWearRequest"
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.full_name = ".RoleBadgeWearRequest"
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEWEARREQUESTHEROUIDFIELD,
	RoleBadgeModule_pb.ROLEBADGEWEARREQUESTWEARFIELD
}
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.name = "position"
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.full_name = ".RoleBadgeWear.position"
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.type = 5
RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD.cpp_type = 1
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.name = "badgeId"
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.full_name = ".RoleBadgeWear.badgeId"
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.number = 2
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.index = 1
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.type = 5
RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD.cpp_type = 1
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.name = "RoleBadgeWear"
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.full_name = ".RoleBadgeWear"
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEWEARPOSITIONFIELD,
	RoleBadgeModule_pb.ROLEBADGEWEARBADGEIDFIELD
}
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEWEAR_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.name = "heroUid"
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.full_name = ".RoleBadgeWearReply.heroUid"
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.number = 1
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.index = 0
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.label = 1
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.default_value = 0
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.type = 3
RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD.cpp_type = 2
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.name = "wears"
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.full_name = ".RoleBadgeWearReply.wears"
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.number = 3
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.index = 1
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.label = 3
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.has_default_value = false
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.default_value = {}
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.message_type = RoleBadgeModule_pb.ROLEBADGEWEAR_MSG
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.type = 11
RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD.cpp_type = 10
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.name = "RoleBadgeWearReply"
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.full_name = ".RoleBadgeWearReply"
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.fields = {
	RoleBadgeModule_pb.ROLEBADGEWEARREPLYHEROUIDFIELD,
	RoleBadgeModule_pb.ROLEBADGEWEARREPLYWEARSFIELD
}
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG.extensions = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.name = "RoleBadgeGetInfoRequest"
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.full_name = ".RoleBadgeGetInfoRequest"
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.nested_types = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.enum_types = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.fields = {}
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.is_extendable = false
RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG.extensions = {}
RoleBadgeModule_pb.RoleBadge = protobuf.Message(RoleBadgeModule_pb.ROLEBADGE_MSG)
RoleBadgeModule_pb.RoleBadgeGetInfoReply = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEGETINFOREPLY_MSG)
RoleBadgeModule_pb.RoleBadgeGetInfoRequest = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEGETINFOREQUEST_MSG)
RoleBadgeModule_pb.RoleBadgeInfo = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEINFO_MSG)
RoleBadgeModule_pb.RoleBadgeRecord = protobuf.Message(RoleBadgeModule_pb.ROLEBADGERECORD_MSG)
RoleBadgeModule_pb.RoleBadgeUpdatePush = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEUPDATEPUSH_MSG)
RoleBadgeModule_pb.RoleBadgeWear = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEWEAR_MSG)
RoleBadgeModule_pb.RoleBadgeWearReply = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEWEARREPLY_MSG)
RoleBadgeModule_pb.RoleBadgeWearRequest = protobuf.Message(RoleBadgeModule_pb.ROLEBADGEWEARREQUEST_MSG)

return RoleBadgeModule_pb
