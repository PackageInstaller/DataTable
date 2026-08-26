-- chunkname: @modules/proto/Activity148Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity148Module_pb", package.seeall)

local Activity148Module_pb = {}

Activity148Module_pb.GET148INFOREPLY_MSG = protobuf.Descriptor()
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG = protobuf.Descriptor()
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.GET148INFOREQUEST_MSG = protobuf.Descriptor()
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148RESETREPLY_MSG = protobuf.Descriptor()
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG = protobuf.Descriptor()
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.SKILLTREEINFO_MSG = protobuf.Descriptor()
Activity148Module_pb.SKILLTREEINFOTYPEFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.SKILLTREEINFOLEVELFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148UPLEVELREPLY_MSG = protobuf.Descriptor()
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148RESETREQUEST_MSG = protobuf.Descriptor()
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG = protobuf.Descriptor()
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD = protobuf.FieldDescriptor()
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.full_name = ".Get148InfoReply.activityId"
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.number = 1
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.index = 0
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.label = 1
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.type = 5
Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.name = "totalSkillPoint"
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.full_name = ".Get148InfoReply.totalSkillPoint"
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.number = 2
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.index = 1
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.label = 1
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.has_default_value = false
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.default_value = 0
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.type = 5
Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD.cpp_type = 1
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.name = "skillTrees"
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.full_name = ".Get148InfoReply.skillTrees"
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.number = 3
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.index = 2
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.label = 3
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.has_default_value = false
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.default_value = {}
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.message_type = Activity148Module_pb.SKILLTREEINFO_MSG
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.type = 11
Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD.cpp_type = 10
Activity148Module_pb.GET148INFOREPLY_MSG.name = "Get148InfoReply"
Activity148Module_pb.GET148INFOREPLY_MSG.full_name = ".Get148InfoReply"
Activity148Module_pb.GET148INFOREPLY_MSG.nested_types = {}
Activity148Module_pb.GET148INFOREPLY_MSG.enum_types = {}
Activity148Module_pb.GET148INFOREPLY_MSG.fields = {
	Activity148Module_pb.GET148INFOREPLYACTIVITYIDFIELD,
	Activity148Module_pb.GET148INFOREPLYTOTALSKILLPOINTFIELD,
	Activity148Module_pb.GET148INFOREPLYSKILLTREESFIELD
}
Activity148Module_pb.GET148INFOREPLY_MSG.is_extendable = false
Activity148Module_pb.GET148INFOREPLY_MSG.extensions = {}
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.full_name = ".Act148UpLevelRequest.activityId"
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.number = 1
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.index = 0
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.label = 1
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.type = 5
Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.name = "type"
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.full_name = ".Act148UpLevelRequest.type"
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.number = 2
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.index = 1
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.label = 1
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.has_default_value = false
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.default_value = 0
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.type = 5
Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD.cpp_type = 1
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.name = "Act148UpLevelRequest"
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.full_name = ".Act148UpLevelRequest"
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.nested_types = {}
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.enum_types = {}
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.fields = {
	Activity148Module_pb.ACT148UPLEVELREQUESTACTIVITYIDFIELD,
	Activity148Module_pb.ACT148UPLEVELREQUESTTYPEFIELD
}
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.is_extendable = false
Activity148Module_pb.ACT148UPLEVELREQUEST_MSG.extensions = {}
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.full_name = ".Get148InfoRequest.activityId"
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.number = 1
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.index = 0
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.label = 1
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.type = 5
Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.GET148INFOREQUEST_MSG.name = "Get148InfoRequest"
Activity148Module_pb.GET148INFOREQUEST_MSG.full_name = ".Get148InfoRequest"
Activity148Module_pb.GET148INFOREQUEST_MSG.nested_types = {}
Activity148Module_pb.GET148INFOREQUEST_MSG.enum_types = {}
Activity148Module_pb.GET148INFOREQUEST_MSG.fields = {
	Activity148Module_pb.GET148INFOREQUESTACTIVITYIDFIELD
}
Activity148Module_pb.GET148INFOREQUEST_MSG.is_extendable = false
Activity148Module_pb.GET148INFOREQUEST_MSG.extensions = {}
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.full_name = ".Act148ResetReply.activityId"
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.number = 1
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.index = 0
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.label = 1
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.type = 5
Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.name = "skillTrees"
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.full_name = ".Act148ResetReply.skillTrees"
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.number = 2
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.index = 1
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.label = 3
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.has_default_value = false
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.default_value = {}
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.message_type = Activity148Module_pb.SKILLTREEINFO_MSG
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.type = 11
Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD.cpp_type = 10
Activity148Module_pb.ACT148RESETREPLY_MSG.name = "Act148ResetReply"
Activity148Module_pb.ACT148RESETREPLY_MSG.full_name = ".Act148ResetReply"
Activity148Module_pb.ACT148RESETREPLY_MSG.nested_types = {}
Activity148Module_pb.ACT148RESETREPLY_MSG.enum_types = {}
Activity148Module_pb.ACT148RESETREPLY_MSG.fields = {
	Activity148Module_pb.ACT148RESETREPLYACTIVITYIDFIELD,
	Activity148Module_pb.ACT148RESETREPLYSKILLTREESFIELD
}
Activity148Module_pb.ACT148RESETREPLY_MSG.is_extendable = false
Activity148Module_pb.ACT148RESETREPLY_MSG.extensions = {}
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.full_name = ".Act148DownLevelRequest.activityId"
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.number = 1
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.index = 0
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.label = 1
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.type = 5
Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.name = "type"
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.full_name = ".Act148DownLevelRequest.type"
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.number = 2
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.index = 1
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.label = 1
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.has_default_value = false
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.default_value = 0
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.type = 5
Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD.cpp_type = 1
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.name = "Act148DownLevelRequest"
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.full_name = ".Act148DownLevelRequest"
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.nested_types = {}
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.enum_types = {}
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.fields = {
	Activity148Module_pb.ACT148DOWNLEVELREQUESTACTIVITYIDFIELD,
	Activity148Module_pb.ACT148DOWNLEVELREQUESTTYPEFIELD
}
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.is_extendable = false
Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG.extensions = {}
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.name = "type"
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.full_name = ".SkillTreeInfo.type"
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.number = 1
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.index = 0
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.label = 1
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.has_default_value = false
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.default_value = 0
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.type = 5
Activity148Module_pb.SKILLTREEINFOTYPEFIELD.cpp_type = 1
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.name = "level"
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.full_name = ".SkillTreeInfo.level"
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.number = 2
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.index = 1
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.label = 1
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.has_default_value = false
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.default_value = 0
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.type = 5
Activity148Module_pb.SKILLTREEINFOLEVELFIELD.cpp_type = 1
Activity148Module_pb.SKILLTREEINFO_MSG.name = "SkillTreeInfo"
Activity148Module_pb.SKILLTREEINFO_MSG.full_name = ".SkillTreeInfo"
Activity148Module_pb.SKILLTREEINFO_MSG.nested_types = {}
Activity148Module_pb.SKILLTREEINFO_MSG.enum_types = {}
Activity148Module_pb.SKILLTREEINFO_MSG.fields = {
	Activity148Module_pb.SKILLTREEINFOTYPEFIELD,
	Activity148Module_pb.SKILLTREEINFOLEVELFIELD
}
Activity148Module_pb.SKILLTREEINFO_MSG.is_extendable = false
Activity148Module_pb.SKILLTREEINFO_MSG.extensions = {}
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.full_name = ".Act148UpLevelReply.activityId"
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.number = 1
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.index = 0
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.label = 1
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.type = 5
Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.name = "skillTree"
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.full_name = ".Act148UpLevelReply.skillTree"
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.number = 2
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.index = 1
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.label = 1
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.has_default_value = false
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.default_value = nil
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.message_type = Activity148Module_pb.SKILLTREEINFO_MSG
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.type = 11
Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD.cpp_type = 10
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.name = "Act148UpLevelReply"
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.full_name = ".Act148UpLevelReply"
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.nested_types = {}
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.enum_types = {}
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.fields = {
	Activity148Module_pb.ACT148UPLEVELREPLYACTIVITYIDFIELD,
	Activity148Module_pb.ACT148UPLEVELREPLYSKILLTREEFIELD
}
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.is_extendable = false
Activity148Module_pb.ACT148UPLEVELREPLY_MSG.extensions = {}
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.full_name = ".Act148ResetRequest.activityId"
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.number = 1
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.index = 0
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.label = 1
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.type = 5
Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.ACT148RESETREQUEST_MSG.name = "Act148ResetRequest"
Activity148Module_pb.ACT148RESETREQUEST_MSG.full_name = ".Act148ResetRequest"
Activity148Module_pb.ACT148RESETREQUEST_MSG.nested_types = {}
Activity148Module_pb.ACT148RESETREQUEST_MSG.enum_types = {}
Activity148Module_pb.ACT148RESETREQUEST_MSG.fields = {
	Activity148Module_pb.ACT148RESETREQUESTACTIVITYIDFIELD
}
Activity148Module_pb.ACT148RESETREQUEST_MSG.is_extendable = false
Activity148Module_pb.ACT148RESETREQUEST_MSG.extensions = {}
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.name = "activityId"
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.full_name = ".Act148DownLevelReply.activityId"
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.number = 1
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.index = 0
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.label = 1
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.has_default_value = false
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.default_value = 0
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.type = 5
Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD.cpp_type = 1
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.name = "skillTree"
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.full_name = ".Act148DownLevelReply.skillTree"
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.number = 2
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.index = 1
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.label = 1
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.has_default_value = false
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.default_value = nil
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.message_type = Activity148Module_pb.SKILLTREEINFO_MSG
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.type = 11
Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD.cpp_type = 10
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.name = "Act148DownLevelReply"
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.full_name = ".Act148DownLevelReply"
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.nested_types = {}
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.enum_types = {}
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.fields = {
	Activity148Module_pb.ACT148DOWNLEVELREPLYACTIVITYIDFIELD,
	Activity148Module_pb.ACT148DOWNLEVELREPLYSKILLTREEFIELD
}
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.is_extendable = false
Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG.extensions = {}
Activity148Module_pb.Act148DownLevelReply = protobuf.Message(Activity148Module_pb.ACT148DOWNLEVELREPLY_MSG)
Activity148Module_pb.Act148DownLevelRequest = protobuf.Message(Activity148Module_pb.ACT148DOWNLEVELREQUEST_MSG)
Activity148Module_pb.Act148ResetReply = protobuf.Message(Activity148Module_pb.ACT148RESETREPLY_MSG)
Activity148Module_pb.Act148ResetRequest = protobuf.Message(Activity148Module_pb.ACT148RESETREQUEST_MSG)
Activity148Module_pb.Act148UpLevelReply = protobuf.Message(Activity148Module_pb.ACT148UPLEVELREPLY_MSG)
Activity148Module_pb.Act148UpLevelRequest = protobuf.Message(Activity148Module_pb.ACT148UPLEVELREQUEST_MSG)
Activity148Module_pb.Get148InfoReply = protobuf.Message(Activity148Module_pb.GET148INFOREPLY_MSG)
Activity148Module_pb.Get148InfoRequest = protobuf.Message(Activity148Module_pb.GET148INFOREQUEST_MSG)
Activity148Module_pb.SkillTreeInfo = protobuf.Message(Activity148Module_pb.SKILLTREEINFO_MSG)

return Activity148Module_pb
