-- chunkname: @modules/proto/Activity221Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity221Module_pb", package.seeall)

local Activity221Module_pb = {}

Activity221Module_pb.GET221INFOREPLY_MSG = protobuf.Descriptor()
Activity221Module_pb.GET221INFOREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.GET221INFOREQUEST_MSG = protobuf.Descriptor()
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221SUMMONREQUEST_MSG = protobuf.Descriptor()
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221INFO_MSG = protobuf.Descriptor()
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221SELECTREQUEST_MSG = protobuf.Descriptor()
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221SELECTREPLY_MSG = protobuf.Descriptor()
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221HEROINFO_MSG = protobuf.Descriptor()
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.ACT221SUMMONREPLY_MSG = protobuf.Descriptor()
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity221Module_pb.GET221INFOREPLYINFOFIELD.name = "info"
Activity221Module_pb.GET221INFOREPLYINFOFIELD.full_name = ".Get221InfoReply.info"
Activity221Module_pb.GET221INFOREPLYINFOFIELD.number = 1
Activity221Module_pb.GET221INFOREPLYINFOFIELD.index = 0
Activity221Module_pb.GET221INFOREPLYINFOFIELD.label = 1
Activity221Module_pb.GET221INFOREPLYINFOFIELD.has_default_value = false
Activity221Module_pb.GET221INFOREPLYINFOFIELD.default_value = nil
Activity221Module_pb.GET221INFOREPLYINFOFIELD.message_type = Activity221Module_pb.ACT221INFO_MSG
Activity221Module_pb.GET221INFOREPLYINFOFIELD.type = 11
Activity221Module_pb.GET221INFOREPLYINFOFIELD.cpp_type = 10
Activity221Module_pb.GET221INFOREPLY_MSG.name = "Get221InfoReply"
Activity221Module_pb.GET221INFOREPLY_MSG.full_name = ".Get221InfoReply"
Activity221Module_pb.GET221INFOREPLY_MSG.nested_types = {}
Activity221Module_pb.GET221INFOREPLY_MSG.enum_types = {}
Activity221Module_pb.GET221INFOREPLY_MSG.fields = {
	Activity221Module_pb.GET221INFOREPLYINFOFIELD
}
Activity221Module_pb.GET221INFOREPLY_MSG.is_extendable = false
Activity221Module_pb.GET221INFOREPLY_MSG.extensions = {}
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.full_name = ".Get221InfoRequest.activityId"
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.number = 1
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.index = 0
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.label = 1
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.type = 5
Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity221Module_pb.GET221INFOREQUEST_MSG.name = "Get221InfoRequest"
Activity221Module_pb.GET221INFOREQUEST_MSG.full_name = ".Get221InfoRequest"
Activity221Module_pb.GET221INFOREQUEST_MSG.nested_types = {}
Activity221Module_pb.GET221INFOREQUEST_MSG.enum_types = {}
Activity221Module_pb.GET221INFOREQUEST_MSG.fields = {
	Activity221Module_pb.GET221INFOREQUESTACTIVITYIDFIELD
}
Activity221Module_pb.GET221INFOREQUEST_MSG.is_extendable = false
Activity221Module_pb.GET221INFOREQUEST_MSG.extensions = {}
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.name = "activityId"
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.full_name = ".Act221SummonRequest.activityId"
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.number = 1
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.index = 0
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.label = 1
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.has_default_value = false
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.default_value = 0
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.type = 5
Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.name = "Act221SummonRequest"
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.full_name = ".Act221SummonRequest"
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.nested_types = {}
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.enum_types = {}
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.fields = {
	Activity221Module_pb.ACT221SUMMONREQUESTACTIVITYIDFIELD
}
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.is_extendable = false
Activity221Module_pb.ACT221SUMMONREQUEST_MSG.extensions = {}
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.name = "activityId"
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.full_name = ".Act221Info.activityId"
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.number = 1
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.index = 0
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.label = 1
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.has_default_value = false
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.default_value = 0
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.type = 5
Activity221Module_pb.ACT221INFOACTIVITYIDFIELD.cpp_type = 1
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.name = "leftTimes"
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.full_name = ".Act221Info.leftTimes"
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.number = 2
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.index = 1
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.label = 1
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.has_default_value = false
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.default_value = 0
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.type = 5
Activity221Module_pb.ACT221INFOLEFTTIMESFIELD.cpp_type = 1
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.name = "savedHeroIds"
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.full_name = ".Act221Info.savedHeroIds"
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.number = 3
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.index = 2
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.label = 3
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.has_default_value = false
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.default_value = {}
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.message_type = Activity221Module_pb.ACT221HEROINFO_MSG
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.type = 11
Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD.cpp_type = 10
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.name = "selectIndex"
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.full_name = ".Act221Info.selectIndex"
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.number = 4
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.index = 3
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.label = 1
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.has_default_value = false
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.default_value = 0
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.type = 5
Activity221Module_pb.ACT221INFOSELECTINDEXFIELD.cpp_type = 1
Activity221Module_pb.ACT221INFO_MSG.name = "Act221Info"
Activity221Module_pb.ACT221INFO_MSG.full_name = ".Act221Info"
Activity221Module_pb.ACT221INFO_MSG.nested_types = {}
Activity221Module_pb.ACT221INFO_MSG.enum_types = {}
Activity221Module_pb.ACT221INFO_MSG.fields = {
	Activity221Module_pb.ACT221INFOACTIVITYIDFIELD,
	Activity221Module_pb.ACT221INFOLEFTTIMESFIELD,
	Activity221Module_pb.ACT221INFOSAVEDHEROIDSFIELD,
	Activity221Module_pb.ACT221INFOSELECTINDEXFIELD
}
Activity221Module_pb.ACT221INFO_MSG.is_extendable = false
Activity221Module_pb.ACT221INFO_MSG.extensions = {}
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.full_name = ".Act221SelectRequest.activityId"
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.number = 1
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.index = 0
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.label = 1
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.default_value = 0
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.type = 5
Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.name = "select"
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.full_name = ".Act221SelectRequest.select"
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.number = 2
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.index = 1
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.label = 1
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.has_default_value = false
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.default_value = 0
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.type = 5
Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD.cpp_type = 1
Activity221Module_pb.ACT221SELECTREQUEST_MSG.name = "Act221SelectRequest"
Activity221Module_pb.ACT221SELECTREQUEST_MSG.full_name = ".Act221SelectRequest"
Activity221Module_pb.ACT221SELECTREQUEST_MSG.nested_types = {}
Activity221Module_pb.ACT221SELECTREQUEST_MSG.enum_types = {}
Activity221Module_pb.ACT221SELECTREQUEST_MSG.fields = {
	Activity221Module_pb.ACT221SELECTREQUESTACTIVITYIDFIELD,
	Activity221Module_pb.ACT221SELECTREQUESTSELECTFIELD
}
Activity221Module_pb.ACT221SELECTREQUEST_MSG.is_extendable = false
Activity221Module_pb.ACT221SELECTREQUEST_MSG.extensions = {}
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.name = "info"
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.full_name = ".Act221SelectReply.info"
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.number = 1
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.index = 0
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.label = 1
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.has_default_value = false
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.default_value = nil
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.message_type = Activity221Module_pb.ACT221INFO_MSG
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.type = 11
Activity221Module_pb.ACT221SELECTREPLYINFOFIELD.cpp_type = 10
Activity221Module_pb.ACT221SELECTREPLY_MSG.name = "Act221SelectReply"
Activity221Module_pb.ACT221SELECTREPLY_MSG.full_name = ".Act221SelectReply"
Activity221Module_pb.ACT221SELECTREPLY_MSG.nested_types = {}
Activity221Module_pb.ACT221SELECTREPLY_MSG.enum_types = {}
Activity221Module_pb.ACT221SELECTREPLY_MSG.fields = {
	Activity221Module_pb.ACT221SELECTREPLYINFOFIELD
}
Activity221Module_pb.ACT221SELECTREPLY_MSG.is_extendable = false
Activity221Module_pb.ACT221SELECTREPLY_MSG.extensions = {}
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.name = "heroId"
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.full_name = ".Act221HeroInfo.heroId"
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.number = 1
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.index = 0
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.label = 3
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.has_default_value = false
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.default_value = {}
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.type = 5
Activity221Module_pb.ACT221HEROINFOHEROIDFIELD.cpp_type = 1
Activity221Module_pb.ACT221HEROINFO_MSG.name = "Act221HeroInfo"
Activity221Module_pb.ACT221HEROINFO_MSG.full_name = ".Act221HeroInfo"
Activity221Module_pb.ACT221HEROINFO_MSG.nested_types = {}
Activity221Module_pb.ACT221HEROINFO_MSG.enum_types = {}
Activity221Module_pb.ACT221HEROINFO_MSG.fields = {
	Activity221Module_pb.ACT221HEROINFOHEROIDFIELD
}
Activity221Module_pb.ACT221HEROINFO_MSG.is_extendable = false
Activity221Module_pb.ACT221HEROINFO_MSG.extensions = {}
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.name = "info"
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.full_name = ".Act221SummonReply.info"
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.number = 1
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.index = 0
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.label = 1
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.has_default_value = false
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.default_value = nil
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.message_type = Activity221Module_pb.ACT221INFO_MSG
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.type = 11
Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD.cpp_type = 10
Activity221Module_pb.ACT221SUMMONREPLY_MSG.name = "Act221SummonReply"
Activity221Module_pb.ACT221SUMMONREPLY_MSG.full_name = ".Act221SummonReply"
Activity221Module_pb.ACT221SUMMONREPLY_MSG.nested_types = {}
Activity221Module_pb.ACT221SUMMONREPLY_MSG.enum_types = {}
Activity221Module_pb.ACT221SUMMONREPLY_MSG.fields = {
	Activity221Module_pb.ACT221SUMMONREPLYINFOFIELD
}
Activity221Module_pb.ACT221SUMMONREPLY_MSG.is_extendable = false
Activity221Module_pb.ACT221SUMMONREPLY_MSG.extensions = {}
Activity221Module_pb.Act221HeroInfo = protobuf.Message(Activity221Module_pb.ACT221HEROINFO_MSG)
Activity221Module_pb.Act221Info = protobuf.Message(Activity221Module_pb.ACT221INFO_MSG)
Activity221Module_pb.Act221SelectReply = protobuf.Message(Activity221Module_pb.ACT221SELECTREPLY_MSG)
Activity221Module_pb.Act221SelectRequest = protobuf.Message(Activity221Module_pb.ACT221SELECTREQUEST_MSG)
Activity221Module_pb.Act221SummonReply = protobuf.Message(Activity221Module_pb.ACT221SUMMONREPLY_MSG)
Activity221Module_pb.Act221SummonRequest = protobuf.Message(Activity221Module_pb.ACT221SUMMONREQUEST_MSG)
Activity221Module_pb.Get221InfoReply = protobuf.Message(Activity221Module_pb.GET221INFOREPLY_MSG)
Activity221Module_pb.Get221InfoRequest = protobuf.Message(Activity221Module_pb.GET221INFOREQUEST_MSG)

return Activity221Module_pb
