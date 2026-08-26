-- chunkname: @modules/proto/Activity170Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity170Module_pb", package.seeall)

local Activity170Module_pb = {}

Activity170Module_pb.ACT170SELECTREQUEST_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SUMMONREPLY_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SELECTREPLY_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SAVEREPLY_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SUMMONREQUEST_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.GET170INFOREPLY_MSG = protobuf.Descriptor()
Activity170Module_pb.GET170INFOREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SAVEREQUEST_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170INFO_MSG = protobuf.Descriptor()
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170INFOISSELECTFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.GET170INFOREQUEST_MSG = protobuf.Descriptor()
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.full_name = ".Act170SelectRequest.activityId"
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.number = 1
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.index = 0
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.label = 1
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.default_value = 0
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.type = 5
Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.name = "select"
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.full_name = ".Act170SelectRequest.select"
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.number = 2
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.index = 1
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.label = 1
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.has_default_value = false
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.default_value = 0
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.type = 5
Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD.cpp_type = 1
Activity170Module_pb.ACT170SELECTREQUEST_MSG.name = "Act170SelectRequest"
Activity170Module_pb.ACT170SELECTREQUEST_MSG.full_name = ".Act170SelectRequest"
Activity170Module_pb.ACT170SELECTREQUEST_MSG.nested_types = {}
Activity170Module_pb.ACT170SELECTREQUEST_MSG.enum_types = {}
Activity170Module_pb.ACT170SELECTREQUEST_MSG.fields = {
	Activity170Module_pb.ACT170SELECTREQUESTACTIVITYIDFIELD,
	Activity170Module_pb.ACT170SELECTREQUESTSELECTFIELD
}
Activity170Module_pb.ACT170SELECTREQUEST_MSG.is_extendable = false
Activity170Module_pb.ACT170SELECTREQUEST_MSG.extensions = {}
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.name = "info"
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.full_name = ".Act170SummonReply.info"
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.number = 1
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.index = 0
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.label = 1
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.has_default_value = false
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.default_value = nil
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.message_type = Activity170Module_pb.ACT170INFO_MSG
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.type = 11
Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD.cpp_type = 10
Activity170Module_pb.ACT170SUMMONREPLY_MSG.name = "Act170SummonReply"
Activity170Module_pb.ACT170SUMMONREPLY_MSG.full_name = ".Act170SummonReply"
Activity170Module_pb.ACT170SUMMONREPLY_MSG.nested_types = {}
Activity170Module_pb.ACT170SUMMONREPLY_MSG.enum_types = {}
Activity170Module_pb.ACT170SUMMONREPLY_MSG.fields = {
	Activity170Module_pb.ACT170SUMMONREPLYINFOFIELD
}
Activity170Module_pb.ACT170SUMMONREPLY_MSG.is_extendable = false
Activity170Module_pb.ACT170SUMMONREPLY_MSG.extensions = {}
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.name = "info"
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.full_name = ".Act170SelectReply.info"
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.number = 1
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.index = 0
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.label = 1
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.has_default_value = false
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.default_value = nil
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.message_type = Activity170Module_pb.ACT170INFO_MSG
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.type = 11
Activity170Module_pb.ACT170SELECTREPLYINFOFIELD.cpp_type = 10
Activity170Module_pb.ACT170SELECTREPLY_MSG.name = "Act170SelectReply"
Activity170Module_pb.ACT170SELECTREPLY_MSG.full_name = ".Act170SelectReply"
Activity170Module_pb.ACT170SELECTREPLY_MSG.nested_types = {}
Activity170Module_pb.ACT170SELECTREPLY_MSG.enum_types = {}
Activity170Module_pb.ACT170SELECTREPLY_MSG.fields = {
	Activity170Module_pb.ACT170SELECTREPLYINFOFIELD
}
Activity170Module_pb.ACT170SELECTREPLY_MSG.is_extendable = false
Activity170Module_pb.ACT170SELECTREPLY_MSG.extensions = {}
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.name = "info"
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.full_name = ".Act170SaveReply.info"
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.number = 1
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.index = 0
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.label = 1
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.has_default_value = false
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.default_value = nil
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.message_type = Activity170Module_pb.ACT170INFO_MSG
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.type = 11
Activity170Module_pb.ACT170SAVEREPLYINFOFIELD.cpp_type = 10
Activity170Module_pb.ACT170SAVEREPLY_MSG.name = "Act170SaveReply"
Activity170Module_pb.ACT170SAVEREPLY_MSG.full_name = ".Act170SaveReply"
Activity170Module_pb.ACT170SAVEREPLY_MSG.nested_types = {}
Activity170Module_pb.ACT170SAVEREPLY_MSG.enum_types = {}
Activity170Module_pb.ACT170SAVEREPLY_MSG.fields = {
	Activity170Module_pb.ACT170SAVEREPLYINFOFIELD
}
Activity170Module_pb.ACT170SAVEREPLY_MSG.is_extendable = false
Activity170Module_pb.ACT170SAVEREPLY_MSG.extensions = {}
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.name = "activityId"
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.full_name = ".Act170SummonRequest.activityId"
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.number = 1
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.index = 0
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.label = 1
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.has_default_value = false
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.default_value = 0
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.type = 5
Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.name = "Act170SummonRequest"
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.full_name = ".Act170SummonRequest"
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.nested_types = {}
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.enum_types = {}
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.fields = {
	Activity170Module_pb.ACT170SUMMONREQUESTACTIVITYIDFIELD
}
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.is_extendable = false
Activity170Module_pb.ACT170SUMMONREQUEST_MSG.extensions = {}
Activity170Module_pb.GET170INFOREPLYINFOFIELD.name = "info"
Activity170Module_pb.GET170INFOREPLYINFOFIELD.full_name = ".Get170InfoReply.info"
Activity170Module_pb.GET170INFOREPLYINFOFIELD.number = 1
Activity170Module_pb.GET170INFOREPLYINFOFIELD.index = 0
Activity170Module_pb.GET170INFOREPLYINFOFIELD.label = 1
Activity170Module_pb.GET170INFOREPLYINFOFIELD.has_default_value = false
Activity170Module_pb.GET170INFOREPLYINFOFIELD.default_value = nil
Activity170Module_pb.GET170INFOREPLYINFOFIELD.message_type = Activity170Module_pb.ACT170INFO_MSG
Activity170Module_pb.GET170INFOREPLYINFOFIELD.type = 11
Activity170Module_pb.GET170INFOREPLYINFOFIELD.cpp_type = 10
Activity170Module_pb.GET170INFOREPLY_MSG.name = "Get170InfoReply"
Activity170Module_pb.GET170INFOREPLY_MSG.full_name = ".Get170InfoReply"
Activity170Module_pb.GET170INFOREPLY_MSG.nested_types = {}
Activity170Module_pb.GET170INFOREPLY_MSG.enum_types = {}
Activity170Module_pb.GET170INFOREPLY_MSG.fields = {
	Activity170Module_pb.GET170INFOREPLYINFOFIELD
}
Activity170Module_pb.GET170INFOREPLY_MSG.is_extendable = false
Activity170Module_pb.GET170INFOREPLY_MSG.extensions = {}
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.full_name = ".Act170SaveRequest.activityId"
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.number = 1
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.index = 0
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.label = 1
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.default_value = 0
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.type = 5
Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity170Module_pb.ACT170SAVEREQUEST_MSG.name = "Act170SaveRequest"
Activity170Module_pb.ACT170SAVEREQUEST_MSG.full_name = ".Act170SaveRequest"
Activity170Module_pb.ACT170SAVEREQUEST_MSG.nested_types = {}
Activity170Module_pb.ACT170SAVEREQUEST_MSG.enum_types = {}
Activity170Module_pb.ACT170SAVEREQUEST_MSG.fields = {
	Activity170Module_pb.ACT170SAVEREQUESTACTIVITYIDFIELD
}
Activity170Module_pb.ACT170SAVEREQUEST_MSG.is_extendable = false
Activity170Module_pb.ACT170SAVEREQUEST_MSG.extensions = {}
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.name = "activityId"
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.full_name = ".Act170Info.activityId"
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.number = 1
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.index = 0
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.label = 1
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.has_default_value = false
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.default_value = 0
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.type = 5
Activity170Module_pb.ACT170INFOACTIVITYIDFIELD.cpp_type = 1
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.name = "leftTimes"
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.full_name = ".Act170Info.leftTimes"
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.number = 2
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.index = 1
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.label = 1
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.has_default_value = false
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.default_value = 0
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.type = 5
Activity170Module_pb.ACT170INFOLEFTTIMESFIELD.cpp_type = 1
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.name = "savedHeroIds"
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.full_name = ".Act170Info.savedHeroIds"
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.number = 3
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.index = 2
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.label = 3
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.has_default_value = false
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.default_value = {}
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.type = 5
Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD.cpp_type = 1
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.name = "currHeroIds"
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.full_name = ".Act170Info.currHeroIds"
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.number = 4
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.index = 3
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.label = 3
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.has_default_value = false
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.default_value = {}
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.type = 5
Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD.cpp_type = 1
Activity170Module_pb.ACT170INFOISSELECTFIELD.name = "isSelect"
Activity170Module_pb.ACT170INFOISSELECTFIELD.full_name = ".Act170Info.isSelect"
Activity170Module_pb.ACT170INFOISSELECTFIELD.number = 5
Activity170Module_pb.ACT170INFOISSELECTFIELD.index = 4
Activity170Module_pb.ACT170INFOISSELECTFIELD.label = 1
Activity170Module_pb.ACT170INFOISSELECTFIELD.has_default_value = false
Activity170Module_pb.ACT170INFOISSELECTFIELD.default_value = false
Activity170Module_pb.ACT170INFOISSELECTFIELD.type = 8
Activity170Module_pb.ACT170INFOISSELECTFIELD.cpp_type = 7
Activity170Module_pb.ACT170INFO_MSG.name = "Act170Info"
Activity170Module_pb.ACT170INFO_MSG.full_name = ".Act170Info"
Activity170Module_pb.ACT170INFO_MSG.nested_types = {}
Activity170Module_pb.ACT170INFO_MSG.enum_types = {}
Activity170Module_pb.ACT170INFO_MSG.fields = {
	Activity170Module_pb.ACT170INFOACTIVITYIDFIELD,
	Activity170Module_pb.ACT170INFOLEFTTIMESFIELD,
	Activity170Module_pb.ACT170INFOSAVEDHEROIDSFIELD,
	Activity170Module_pb.ACT170INFOCURRHEROIDSFIELD,
	Activity170Module_pb.ACT170INFOISSELECTFIELD
}
Activity170Module_pb.ACT170INFO_MSG.is_extendable = false
Activity170Module_pb.ACT170INFO_MSG.extensions = {}
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.full_name = ".Get170InfoRequest.activityId"
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.number = 1
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.index = 0
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.label = 1
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.type = 5
Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity170Module_pb.GET170INFOREQUEST_MSG.name = "Get170InfoRequest"
Activity170Module_pb.GET170INFOREQUEST_MSG.full_name = ".Get170InfoRequest"
Activity170Module_pb.GET170INFOREQUEST_MSG.nested_types = {}
Activity170Module_pb.GET170INFOREQUEST_MSG.enum_types = {}
Activity170Module_pb.GET170INFOREQUEST_MSG.fields = {
	Activity170Module_pb.GET170INFOREQUESTACTIVITYIDFIELD
}
Activity170Module_pb.GET170INFOREQUEST_MSG.is_extendable = false
Activity170Module_pb.GET170INFOREQUEST_MSG.extensions = {}
Activity170Module_pb.Act170Info = protobuf.Message(Activity170Module_pb.ACT170INFO_MSG)
Activity170Module_pb.Act170SaveReply = protobuf.Message(Activity170Module_pb.ACT170SAVEREPLY_MSG)
Activity170Module_pb.Act170SaveRequest = protobuf.Message(Activity170Module_pb.ACT170SAVEREQUEST_MSG)
Activity170Module_pb.Act170SelectReply = protobuf.Message(Activity170Module_pb.ACT170SELECTREPLY_MSG)
Activity170Module_pb.Act170SelectRequest = protobuf.Message(Activity170Module_pb.ACT170SELECTREQUEST_MSG)
Activity170Module_pb.Act170SummonReply = protobuf.Message(Activity170Module_pb.ACT170SUMMONREPLY_MSG)
Activity170Module_pb.Act170SummonRequest = protobuf.Message(Activity170Module_pb.ACT170SUMMONREQUEST_MSG)
Activity170Module_pb.Get170InfoReply = protobuf.Message(Activity170Module_pb.GET170INFOREPLY_MSG)
Activity170Module_pb.Get170InfoRequest = protobuf.Message(Activity170Module_pb.GET170INFOREQUEST_MSG)

return Activity170Module_pb
