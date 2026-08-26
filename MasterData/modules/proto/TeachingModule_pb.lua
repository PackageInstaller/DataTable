-- chunkname: @modules/proto/TeachingModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.TeachingModule_pb", package.seeall)

local TeachingModule_pb = {}

TeachingModule_pb.TEACHINGINFO_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHING_MSG = protobuf.Descriptor()
TeachingModule_pb.TEACHINGTEACHINGIDFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGSTATUSFIELD = protobuf.FieldDescriptor()
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.name = "teachinges"
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.full_name = ".TeachingInfo.teachinges"
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.number = 1
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.index = 0
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.label = 3
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.has_default_value = false
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.default_value = {}
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.message_type = TeachingModule_pb.TEACHING_MSG
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.type = 11
TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD.cpp_type = 10
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.name = "passEpisodes"
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.full_name = ".TeachingInfo.passEpisodes"
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.number = 2
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.index = 1
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.label = 3
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.has_default_value = false
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.default_value = {}
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.type = 5
TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD.cpp_type = 1
TeachingModule_pb.TEACHINGINFO_MSG.name = "TeachingInfo"
TeachingModule_pb.TEACHINGINFO_MSG.full_name = ".TeachingInfo"
TeachingModule_pb.TEACHINGINFO_MSG.nested_types = {}
TeachingModule_pb.TEACHINGINFO_MSG.enum_types = {}
TeachingModule_pb.TEACHINGINFO_MSG.fields = {
	TeachingModule_pb.TEACHINGINFOTEACHINGESFIELD,
	TeachingModule_pb.TEACHINGINFOPASSEPISODESFIELD
}
TeachingModule_pb.TEACHINGINFO_MSG.is_extendable = false
TeachingModule_pb.TEACHINGINFO_MSG.extensions = {}
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.name = "teachingInfo"
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.full_name = ".TeachingGetInfoReply.teachingInfo"
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.number = 1
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.index = 0
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.label = 1
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.has_default_value = false
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.default_value = nil
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.message_type = TeachingModule_pb.TEACHINGINFO_MSG
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.type = 11
TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD.cpp_type = 10
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.name = "TeachingGetInfoReply"
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.full_name = ".TeachingGetInfoReply"
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.nested_types = {}
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.enum_types = {}
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.fields = {
	TeachingModule_pb.TEACHINGGETINFOREPLYTEACHINGINFOFIELD
}
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.is_extendable = false
TeachingModule_pb.TEACHINGGETINFOREPLY_MSG.extensions = {}
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.name = "TeachingGetInfoRequest"
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.full_name = ".TeachingGetInfoRequest"
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.nested_types = {}
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.enum_types = {}
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.fields = {}
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.is_extendable = false
TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG.extensions = {}
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.name = "teachinges"
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.full_name = ".TeachingGetBonusReply.teachinges"
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.number = 1
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.index = 0
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.label = 3
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.has_default_value = false
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.default_value = {}
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.message_type = TeachingModule_pb.TEACHING_MSG
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.type = 11
TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD.cpp_type = 10
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.name = "TeachingGetBonusReply"
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.full_name = ".TeachingGetBonusReply"
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.nested_types = {}
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.enum_types = {}
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.fields = {
	TeachingModule_pb.TEACHINGGETBONUSREPLYTEACHINGESFIELD
}
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.is_extendable = false
TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG.extensions = {}
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.name = "teachingIds"
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.full_name = ".TeachingGetBonusRequest.teachingIds"
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.number = 1
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.index = 0
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.label = 3
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.has_default_value = false
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.default_value = {}
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.type = 5
TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD.cpp_type = 1
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.name = "TeachingGetBonusRequest"
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.full_name = ".TeachingGetBonusRequest"
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.nested_types = {}
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.enum_types = {}
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.fields = {
	TeachingModule_pb.TEACHINGGETBONUSREQUESTTEACHINGIDSFIELD
}
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.is_extendable = false
TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG.extensions = {}
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.name = "teachingInfo"
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.full_name = ".TeachingUpdateInfoPush.teachingInfo"
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.number = 1
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.index = 0
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.label = 1
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.has_default_value = false
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.default_value = nil
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.message_type = TeachingModule_pb.TEACHINGINFO_MSG
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.type = 11
TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD.cpp_type = 10
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.name = "TeachingUpdateInfoPush"
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.full_name = ".TeachingUpdateInfoPush"
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.nested_types = {}
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.enum_types = {}
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.fields = {
	TeachingModule_pb.TEACHINGUPDATEINFOPUSHTEACHINGINFOFIELD
}
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.is_extendable = false
TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG.extensions = {}
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.name = "teachingId"
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.full_name = ".Teaching.teachingId"
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.number = 1
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.index = 0
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.label = 1
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.has_default_value = false
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.default_value = 0
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.type = 5
TeachingModule_pb.TEACHINGTEACHINGIDFIELD.cpp_type = 1
TeachingModule_pb.TEACHINGSTATUSFIELD.name = "status"
TeachingModule_pb.TEACHINGSTATUSFIELD.full_name = ".Teaching.status"
TeachingModule_pb.TEACHINGSTATUSFIELD.number = 2
TeachingModule_pb.TEACHINGSTATUSFIELD.index = 1
TeachingModule_pb.TEACHINGSTATUSFIELD.label = 1
TeachingModule_pb.TEACHINGSTATUSFIELD.has_default_value = false
TeachingModule_pb.TEACHINGSTATUSFIELD.default_value = 0
TeachingModule_pb.TEACHINGSTATUSFIELD.type = 5
TeachingModule_pb.TEACHINGSTATUSFIELD.cpp_type = 1
TeachingModule_pb.TEACHING_MSG.name = "Teaching"
TeachingModule_pb.TEACHING_MSG.full_name = ".Teaching"
TeachingModule_pb.TEACHING_MSG.nested_types = {}
TeachingModule_pb.TEACHING_MSG.enum_types = {}
TeachingModule_pb.TEACHING_MSG.fields = {
	TeachingModule_pb.TEACHINGTEACHINGIDFIELD,
	TeachingModule_pb.TEACHINGSTATUSFIELD
}
TeachingModule_pb.TEACHING_MSG.is_extendable = false
TeachingModule_pb.TEACHING_MSG.extensions = {}
TeachingModule_pb.Teaching = protobuf.Message(TeachingModule_pb.TEACHING_MSG)
TeachingModule_pb.TeachingGetBonusReply = protobuf.Message(TeachingModule_pb.TEACHINGGETBONUSREPLY_MSG)
TeachingModule_pb.TeachingGetBonusRequest = protobuf.Message(TeachingModule_pb.TEACHINGGETBONUSREQUEST_MSG)
TeachingModule_pb.TeachingGetInfoReply = protobuf.Message(TeachingModule_pb.TEACHINGGETINFOREPLY_MSG)
TeachingModule_pb.TeachingGetInfoRequest = protobuf.Message(TeachingModule_pb.TEACHINGGETINFOREQUEST_MSG)
TeachingModule_pb.TeachingInfo = protobuf.Message(TeachingModule_pb.TEACHINGINFO_MSG)
TeachingModule_pb.TeachingUpdateInfoPush = protobuf.Message(TeachingModule_pb.TEACHINGUPDATEINFOPUSH_MSG)

return TeachingModule_pb
