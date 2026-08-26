-- chunkname: @modules/proto/Activity121Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity121Module_pb", package.seeall)

local Activity121Module_pb = {}

Activity121Module_pb.ACT121INFO_MSG = protobuf.Descriptor()
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.ACT121INFONOTESFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.GET121BONUSREPLY_MSG = protobuf.Descriptor()
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.GET121INFOSREQUEST_MSG = protobuf.Descriptor()
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.GET121INFOSREPLY_MSG = protobuf.Descriptor()
Activity121Module_pb.GET121INFOSREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.GET121BONUSREQUEST_MSG = protobuf.Descriptor()
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.ACT121UPDATEPUSH_MSG = protobuf.Descriptor()
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD = protobuf.FieldDescriptor()
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.name = "activityId"
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.full_name = ".Act121Info.activityId"
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.number = 1
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.index = 0
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.label = 1
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.has_default_value = false
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.default_value = 0
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.type = 5
Activity121Module_pb.ACT121INFOACTIVITYIDFIELD.cpp_type = 1
Activity121Module_pb.ACT121INFONOTESFIELD.name = "notes"
Activity121Module_pb.ACT121INFONOTESFIELD.full_name = ".Act121Info.notes"
Activity121Module_pb.ACT121INFONOTESFIELD.number = 3
Activity121Module_pb.ACT121INFONOTESFIELD.index = 1
Activity121Module_pb.ACT121INFONOTESFIELD.label = 3
Activity121Module_pb.ACT121INFONOTESFIELD.has_default_value = false
Activity121Module_pb.ACT121INFONOTESFIELD.default_value = {}
Activity121Module_pb.ACT121INFONOTESFIELD.type = 5
Activity121Module_pb.ACT121INFONOTESFIELD.cpp_type = 1
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.name = "getBonusStory"
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.full_name = ".Act121Info.getBonusStory"
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.number = 4
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.index = 2
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.label = 3
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.has_default_value = false
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.default_value = {}
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.type = 5
Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD.cpp_type = 1
Activity121Module_pb.ACT121INFO_MSG.name = "Act121Info"
Activity121Module_pb.ACT121INFO_MSG.full_name = ".Act121Info"
Activity121Module_pb.ACT121INFO_MSG.nested_types = {}
Activity121Module_pb.ACT121INFO_MSG.enum_types = {}
Activity121Module_pb.ACT121INFO_MSG.fields = {
	Activity121Module_pb.ACT121INFOACTIVITYIDFIELD,
	Activity121Module_pb.ACT121INFONOTESFIELD,
	Activity121Module_pb.ACT121INFOGETBONUSSTORYFIELD
}
Activity121Module_pb.ACT121INFO_MSG.is_extendable = false
Activity121Module_pb.ACT121INFO_MSG.extensions = {}
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.full_name = ".Get121BonusReply.activityId"
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.number = 1
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.index = 0
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.label = 1
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.type = 5
Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.name = "storyId"
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.full_name = ".Get121BonusReply.storyId"
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.number = 2
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.index = 1
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.label = 1
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.has_default_value = false
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.default_value = 0
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.type = 5
Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD.cpp_type = 1
Activity121Module_pb.GET121BONUSREPLY_MSG.name = "Get121BonusReply"
Activity121Module_pb.GET121BONUSREPLY_MSG.full_name = ".Get121BonusReply"
Activity121Module_pb.GET121BONUSREPLY_MSG.nested_types = {}
Activity121Module_pb.GET121BONUSREPLY_MSG.enum_types = {}
Activity121Module_pb.GET121BONUSREPLY_MSG.fields = {
	Activity121Module_pb.GET121BONUSREPLYACTIVITYIDFIELD,
	Activity121Module_pb.GET121BONUSREPLYSTORYIDFIELD
}
Activity121Module_pb.GET121BONUSREPLY_MSG.is_extendable = false
Activity121Module_pb.GET121BONUSREPLY_MSG.extensions = {}
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get121InfosRequest.activityId"
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity121Module_pb.GET121INFOSREQUEST_MSG.name = "Get121InfosRequest"
Activity121Module_pb.GET121INFOSREQUEST_MSG.full_name = ".Get121InfosRequest"
Activity121Module_pb.GET121INFOSREQUEST_MSG.nested_types = {}
Activity121Module_pb.GET121INFOSREQUEST_MSG.enum_types = {}
Activity121Module_pb.GET121INFOSREQUEST_MSG.fields = {
	Activity121Module_pb.GET121INFOSREQUESTACTIVITYIDFIELD
}
Activity121Module_pb.GET121INFOSREQUEST_MSG.is_extendable = false
Activity121Module_pb.GET121INFOSREQUEST_MSG.extensions = {}
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.name = "info"
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.full_name = ".Get121InfosReply.info"
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.number = 1
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.index = 0
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.label = 1
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.has_default_value = false
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.default_value = nil
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.message_type = Activity121Module_pb.ACT121INFO_MSG
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.type = 11
Activity121Module_pb.GET121INFOSREPLYINFOFIELD.cpp_type = 10
Activity121Module_pb.GET121INFOSREPLY_MSG.name = "Get121InfosReply"
Activity121Module_pb.GET121INFOSREPLY_MSG.full_name = ".Get121InfosReply"
Activity121Module_pb.GET121INFOSREPLY_MSG.nested_types = {}
Activity121Module_pb.GET121INFOSREPLY_MSG.enum_types = {}
Activity121Module_pb.GET121INFOSREPLY_MSG.fields = {
	Activity121Module_pb.GET121INFOSREPLYINFOFIELD
}
Activity121Module_pb.GET121INFOSREPLY_MSG.is_extendable = false
Activity121Module_pb.GET121INFOSREPLY_MSG.extensions = {}
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.full_name = ".Get121BonusRequest.activityId"
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.name = "storyId"
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.full_name = ".Get121BonusRequest.storyId"
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.number = 2
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.index = 1
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.label = 1
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.has_default_value = false
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.default_value = 0
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.type = 5
Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD.cpp_type = 1
Activity121Module_pb.GET121BONUSREQUEST_MSG.name = "Get121BonusRequest"
Activity121Module_pb.GET121BONUSREQUEST_MSG.full_name = ".Get121BonusRequest"
Activity121Module_pb.GET121BONUSREQUEST_MSG.nested_types = {}
Activity121Module_pb.GET121BONUSREQUEST_MSG.enum_types = {}
Activity121Module_pb.GET121BONUSREQUEST_MSG.fields = {
	Activity121Module_pb.GET121BONUSREQUESTACTIVITYIDFIELD,
	Activity121Module_pb.GET121BONUSREQUESTSTORYIDFIELD
}
Activity121Module_pb.GET121BONUSREQUEST_MSG.is_extendable = false
Activity121Module_pb.GET121BONUSREQUEST_MSG.extensions = {}
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.name = "info"
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.full_name = ".Act121UpdatePush.info"
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.number = 1
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.index = 0
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.label = 1
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.has_default_value = false
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.default_value = nil
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.message_type = Activity121Module_pb.ACT121INFO_MSG
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.type = 11
Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD.cpp_type = 10
Activity121Module_pb.ACT121UPDATEPUSH_MSG.name = "Act121UpdatePush"
Activity121Module_pb.ACT121UPDATEPUSH_MSG.full_name = ".Act121UpdatePush"
Activity121Module_pb.ACT121UPDATEPUSH_MSG.nested_types = {}
Activity121Module_pb.ACT121UPDATEPUSH_MSG.enum_types = {}
Activity121Module_pb.ACT121UPDATEPUSH_MSG.fields = {
	Activity121Module_pb.ACT121UPDATEPUSHINFOFIELD
}
Activity121Module_pb.ACT121UPDATEPUSH_MSG.is_extendable = false
Activity121Module_pb.ACT121UPDATEPUSH_MSG.extensions = {}
Activity121Module_pb.Act121Info = protobuf.Message(Activity121Module_pb.ACT121INFO_MSG)
Activity121Module_pb.Act121UpdatePush = protobuf.Message(Activity121Module_pb.ACT121UPDATEPUSH_MSG)
Activity121Module_pb.Get121BonusReply = protobuf.Message(Activity121Module_pb.GET121BONUSREPLY_MSG)
Activity121Module_pb.Get121BonusRequest = protobuf.Message(Activity121Module_pb.GET121BONUSREQUEST_MSG)
Activity121Module_pb.Get121InfosReply = protobuf.Message(Activity121Module_pb.GET121INFOSREPLY_MSG)
Activity121Module_pb.Get121InfosRequest = protobuf.Message(Activity121Module_pb.GET121INFOSREQUEST_MSG)

return Activity121Module_pb
