-- chunkname: @modules/proto/Activity115Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity115Module_pb", package.seeall)

local Activity115Module_pb = {}

Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.GETACT115INFOREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.GETACT115INFOREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115OPERATION_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115OPERATIONIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115USESKILLREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115MAP_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115MAPIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STEP_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115STEPPARAMFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115ABORTREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115ABORTREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115EVENT_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115EVENTPARAMFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115REVERTREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115EPISODE_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115EPISODEIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115EPISODESTARFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STEPPUSH_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BONUSREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115USESKILLREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115EVENTENDREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BONUSREPLY_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115INTERACTOBJECT_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115REVERTREQUEST_MSG = protobuf.Descriptor()
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.full_name = ".Act115StartEpisodeRequest.activityId"
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.name = "id"
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.full_name = ".Act115StartEpisodeRequest.id"
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.number = 2
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.index = 1
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.label = 1
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.has_default_value = false
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.default_value = 0
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.type = 5
Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.name = "Act115StartEpisodeRequest"
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.full_name = ".Act115StartEpisodeRequest"
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115STARTEPISODEREQUESTACTIVITYIDFIELD,
	Activity115Module_pb.ACT115STARTEPISODEREQUESTIDFIELD
}
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG.extensions = {}
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct115InfoRequest.activityId"
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.GETACT115INFOREQUEST_MSG.name = "GetAct115InfoRequest"
Activity115Module_pb.GETACT115INFOREQUEST_MSG.full_name = ".GetAct115InfoRequest"
Activity115Module_pb.GETACT115INFOREQUEST_MSG.nested_types = {}
Activity115Module_pb.GETACT115INFOREQUEST_MSG.enum_types = {}
Activity115Module_pb.GETACT115INFOREQUEST_MSG.fields = {
	Activity115Module_pb.GETACT115INFOREQUESTACTIVITYIDFIELD
}
Activity115Module_pb.GETACT115INFOREQUEST_MSG.is_extendable = false
Activity115Module_pb.GETACT115INFOREQUEST_MSG.extensions = {}
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct115InfoReply.activityId"
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.name = "map"
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.full_name = ".GetAct115InfoReply.map"
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.number = 2
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.index = 1
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.label = 1
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.has_default_value = false
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.default_value = nil
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.message_type = Activity115Module_pb.ACT115MAP_MSG
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.type = 11
Activity115Module_pb.GETACT115INFOREPLYMAPFIELD.cpp_type = 10
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.name = "episodes"
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.full_name = ".GetAct115InfoReply.episodes"
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.number = 3
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.index = 2
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.label = 3
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.has_default_value = false
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.default_value = {}
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.message_type = Activity115Module_pb.ACT115EPISODE_MSG
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.type = 11
Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD.cpp_type = 10
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.full_name = ".GetAct115InfoReply.hasGetBonusIds"
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.number = 4
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.index = 3
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.label = 3
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.has_default_value = false
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.default_value = {}
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.type = 5
Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD.cpp_type = 1
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.name = "score"
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.full_name = ".GetAct115InfoReply.score"
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.number = 5
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.index = 4
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.label = 1
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.has_default_value = false
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.default_value = 0
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.type = 5
Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD.cpp_type = 1
Activity115Module_pb.GETACT115INFOREPLY_MSG.name = "GetAct115InfoReply"
Activity115Module_pb.GETACT115INFOREPLY_MSG.full_name = ".GetAct115InfoReply"
Activity115Module_pb.GETACT115INFOREPLY_MSG.nested_types = {}
Activity115Module_pb.GETACT115INFOREPLY_MSG.enum_types = {}
Activity115Module_pb.GETACT115INFOREPLY_MSG.fields = {
	Activity115Module_pb.GETACT115INFOREPLYACTIVITYIDFIELD,
	Activity115Module_pb.GETACT115INFOREPLYMAPFIELD,
	Activity115Module_pb.GETACT115INFOREPLYEPISODESFIELD,
	Activity115Module_pb.GETACT115INFOREPLYHASGETBONUSIDSFIELD,
	Activity115Module_pb.GETACT115INFOREPLYSCOREFIELD
}
Activity115Module_pb.GETACT115INFOREPLY_MSG.is_extendable = false
Activity115Module_pb.GETACT115INFOREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115OPERATIONIDFIELD.name = "id"
Activity115Module_pb.ACT115OPERATIONIDFIELD.full_name = ".Act115Operation.id"
Activity115Module_pb.ACT115OPERATIONIDFIELD.number = 1
Activity115Module_pb.ACT115OPERATIONIDFIELD.index = 0
Activity115Module_pb.ACT115OPERATIONIDFIELD.label = 1
Activity115Module_pb.ACT115OPERATIONIDFIELD.has_default_value = false
Activity115Module_pb.ACT115OPERATIONIDFIELD.default_value = 0
Activity115Module_pb.ACT115OPERATIONIDFIELD.type = 5
Activity115Module_pb.ACT115OPERATIONIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.name = "moveDirection"
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.full_name = ".Act115Operation.moveDirection"
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.number = 2
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.index = 1
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.label = 1
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.has_default_value = false
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.default_value = 0
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.type = 5
Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD.cpp_type = 1
Activity115Module_pb.ACT115OPERATION_MSG.name = "Act115Operation"
Activity115Module_pb.ACT115OPERATION_MSG.full_name = ".Act115Operation"
Activity115Module_pb.ACT115OPERATION_MSG.nested_types = {}
Activity115Module_pb.ACT115OPERATION_MSG.enum_types = {}
Activity115Module_pb.ACT115OPERATION_MSG.fields = {
	Activity115Module_pb.ACT115OPERATIONIDFIELD,
	Activity115Module_pb.ACT115OPERATIONMOVEDIRECTIONFIELD
}
Activity115Module_pb.ACT115OPERATION_MSG.is_extendable = false
Activity115Module_pb.ACT115OPERATION_MSG.extensions = {}
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.full_name = ".Act115UseSkillRequest.activityId"
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.name = "skillId"
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.full_name = ".Act115UseSkillRequest.skillId"
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.number = 2
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.index = 1
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.label = 1
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.has_default_value = false
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.default_value = 0
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.type = 5
Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.name = "Act115UseSkillRequest"
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.full_name = ".Act115UseSkillRequest"
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115USESKILLREQUESTACTIVITYIDFIELD,
	Activity115Module_pb.ACT115USESKILLREQUESTSKILLIDFIELD
}
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115USESKILLREQUEST_MSG.extensions = {}
Activity115Module_pb.ACT115MAPIDFIELD.name = "id"
Activity115Module_pb.ACT115MAPIDFIELD.full_name = ".Act115Map.id"
Activity115Module_pb.ACT115MAPIDFIELD.number = 1
Activity115Module_pb.ACT115MAPIDFIELD.index = 0
Activity115Module_pb.ACT115MAPIDFIELD.label = 1
Activity115Module_pb.ACT115MAPIDFIELD.has_default_value = false
Activity115Module_pb.ACT115MAPIDFIELD.default_value = 0
Activity115Module_pb.ACT115MAPIDFIELD.type = 5
Activity115Module_pb.ACT115MAPIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.name = "interactObjects"
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.full_name = ".Act115Map.interactObjects"
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.number = 2
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.index = 1
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.label = 3
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.has_default_value = false
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.default_value = {}
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.message_type = Activity115Module_pb.ACT115INTERACTOBJECT_MSG
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.type = 11
Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD.cpp_type = 10
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.name = "currentEvent"
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.full_name = ".Act115Map.currentEvent"
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.number = 3
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.index = 2
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.label = 1
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.has_default_value = false
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.default_value = nil
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.message_type = Activity115Module_pb.ACT115EVENT_MSG
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.type = 11
Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD.cpp_type = 10
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.name = "currentRound"
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.full_name = ".Act115Map.currentRound"
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.number = 4
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.index = 3
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.label = 1
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.has_default_value = false
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.default_value = 0
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.type = 5
Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD.cpp_type = 1
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.name = "finishInteracts"
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.full_name = ".Act115Map.finishInteracts"
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.number = 5
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.index = 4
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.label = 3
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.has_default_value = false
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.default_value = {}
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.type = 5
Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD.cpp_type = 1
Activity115Module_pb.ACT115MAP_MSG.name = "Act115Map"
Activity115Module_pb.ACT115MAP_MSG.full_name = ".Act115Map"
Activity115Module_pb.ACT115MAP_MSG.nested_types = {}
Activity115Module_pb.ACT115MAP_MSG.enum_types = {}
Activity115Module_pb.ACT115MAP_MSG.fields = {
	Activity115Module_pb.ACT115MAPIDFIELD,
	Activity115Module_pb.ACT115MAPINTERACTOBJECTSFIELD,
	Activity115Module_pb.ACT115MAPCURRENTEVENTFIELD,
	Activity115Module_pb.ACT115MAPCURRENTROUNDFIELD,
	Activity115Module_pb.ACT115MAPFINISHINTERACTSFIELD
}
Activity115Module_pb.ACT115MAP_MSG.is_extendable = false
Activity115Module_pb.ACT115MAP_MSG.extensions = {}
Activity115Module_pb.ACT115STEPPARAMFIELD.name = "param"
Activity115Module_pb.ACT115STEPPARAMFIELD.full_name = ".Act115Step.param"
Activity115Module_pb.ACT115STEPPARAMFIELD.number = 1
Activity115Module_pb.ACT115STEPPARAMFIELD.index = 0
Activity115Module_pb.ACT115STEPPARAMFIELD.label = 1
Activity115Module_pb.ACT115STEPPARAMFIELD.has_default_value = false
Activity115Module_pb.ACT115STEPPARAMFIELD.default_value = ""
Activity115Module_pb.ACT115STEPPARAMFIELD.type = 9
Activity115Module_pb.ACT115STEPPARAMFIELD.cpp_type = 9
Activity115Module_pb.ACT115STEP_MSG.name = "Act115Step"
Activity115Module_pb.ACT115STEP_MSG.full_name = ".Act115Step"
Activity115Module_pb.ACT115STEP_MSG.nested_types = {}
Activity115Module_pb.ACT115STEP_MSG.enum_types = {}
Activity115Module_pb.ACT115STEP_MSG.fields = {
	Activity115Module_pb.ACT115STEPPARAMFIELD
}
Activity115Module_pb.ACT115STEP_MSG.is_extendable = false
Activity115Module_pb.ACT115STEP_MSG.extensions = {}
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.full_name = ".Act115AbortReply.activityId"
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115ABORTREPLY_MSG.name = "Act115AbortReply"
Activity115Module_pb.ACT115ABORTREPLY_MSG.full_name = ".Act115AbortReply"
Activity115Module_pb.ACT115ABORTREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115ABORTREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115ABORTREPLY_MSG.fields = {
	Activity115Module_pb.ACT115ABORTREPLYACTIVITYIDFIELD
}
Activity115Module_pb.ACT115ABORTREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115ABORTREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.full_name = ".Act115StartEpisodeReply.activityId"
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.name = "map"
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.full_name = ".Act115StartEpisodeReply.map"
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.number = 2
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.index = 1
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.label = 1
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.has_default_value = false
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.default_value = nil
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.message_type = Activity115Module_pb.ACT115MAP_MSG
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.type = 11
Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD.cpp_type = 10
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.name = "Act115StartEpisodeReply"
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.full_name = ".Act115StartEpisodeReply"
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.fields = {
	Activity115Module_pb.ACT115STARTEPISODEREPLYACTIVITYIDFIELD,
	Activity115Module_pb.ACT115STARTEPISODEREPLYMAPFIELD
}
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.full_name = ".Act115BeginRoundReply.activityId"
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.name = "operations"
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.full_name = ".Act115BeginRoundReply.operations"
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.number = 2
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.index = 1
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.label = 3
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.has_default_value = false
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.default_value = {}
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.message_type = Activity115Module_pb.ACT115OPERATION_MSG
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.type = 11
Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD.cpp_type = 10
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.name = "useSikills"
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.full_name = ".Act115BeginRoundReply.useSikills"
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.number = 3
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.index = 2
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.label = 3
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.has_default_value = false
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.default_value = {}
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.type = 5
Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD.cpp_type = 1
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.name = "Act115BeginRoundReply"
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.full_name = ".Act115BeginRoundReply"
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.fields = {
	Activity115Module_pb.ACT115BEGINROUNDREPLYACTIVITYIDFIELD,
	Activity115Module_pb.ACT115BEGINROUNDREPLYOPERATIONSFIELD,
	Activity115Module_pb.ACT115BEGINROUNDREPLYUSESIKILLSFIELD
}
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.full_name = ".Act115AbortRequest.activityId"
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115ABORTREQUEST_MSG.name = "Act115AbortRequest"
Activity115Module_pb.ACT115ABORTREQUEST_MSG.full_name = ".Act115AbortRequest"
Activity115Module_pb.ACT115ABORTREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115ABORTREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115ABORTREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115ABORTREQUESTACTIVITYIDFIELD
}
Activity115Module_pb.ACT115ABORTREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115ABORTREQUEST_MSG.extensions = {}
Activity115Module_pb.ACT115EVENTPARAMFIELD.name = "param"
Activity115Module_pb.ACT115EVENTPARAMFIELD.full_name = ".Act115Event.param"
Activity115Module_pb.ACT115EVENTPARAMFIELD.number = 1
Activity115Module_pb.ACT115EVENTPARAMFIELD.index = 0
Activity115Module_pb.ACT115EVENTPARAMFIELD.label = 1
Activity115Module_pb.ACT115EVENTPARAMFIELD.has_default_value = false
Activity115Module_pb.ACT115EVENTPARAMFIELD.default_value = ""
Activity115Module_pb.ACT115EVENTPARAMFIELD.type = 9
Activity115Module_pb.ACT115EVENTPARAMFIELD.cpp_type = 9
Activity115Module_pb.ACT115EVENT_MSG.name = "Act115Event"
Activity115Module_pb.ACT115EVENT_MSG.full_name = ".Act115Event"
Activity115Module_pb.ACT115EVENT_MSG.nested_types = {}
Activity115Module_pb.ACT115EVENT_MSG.enum_types = {}
Activity115Module_pb.ACT115EVENT_MSG.fields = {
	Activity115Module_pb.ACT115EVENTPARAMFIELD
}
Activity115Module_pb.ACT115EVENT_MSG.is_extendable = false
Activity115Module_pb.ACT115EVENT_MSG.extensions = {}
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.full_name = ".Act115RevertReply.activityId"
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.name = "map"
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.full_name = ".Act115RevertReply.map"
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.number = 2
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.index = 1
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.label = 1
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.has_default_value = false
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.default_value = nil
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.message_type = Activity115Module_pb.ACT115MAP_MSG
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.type = 11
Activity115Module_pb.ACT115REVERTREPLYMAPFIELD.cpp_type = 10
Activity115Module_pb.ACT115REVERTREPLY_MSG.name = "Act115RevertReply"
Activity115Module_pb.ACT115REVERTREPLY_MSG.full_name = ".Act115RevertReply"
Activity115Module_pb.ACT115REVERTREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115REVERTREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115REVERTREPLY_MSG.fields = {
	Activity115Module_pb.ACT115REVERTREPLYACTIVITYIDFIELD,
	Activity115Module_pb.ACT115REVERTREPLYMAPFIELD
}
Activity115Module_pb.ACT115REVERTREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115REVERTREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115EPISODEIDFIELD.name = "id"
Activity115Module_pb.ACT115EPISODEIDFIELD.full_name = ".Act115Episode.id"
Activity115Module_pb.ACT115EPISODEIDFIELD.number = 1
Activity115Module_pb.ACT115EPISODEIDFIELD.index = 0
Activity115Module_pb.ACT115EPISODEIDFIELD.label = 1
Activity115Module_pb.ACT115EPISODEIDFIELD.has_default_value = false
Activity115Module_pb.ACT115EPISODEIDFIELD.default_value = 0
Activity115Module_pb.ACT115EPISODEIDFIELD.type = 5
Activity115Module_pb.ACT115EPISODEIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115EPISODESTARFIELD.name = "star"
Activity115Module_pb.ACT115EPISODESTARFIELD.full_name = ".Act115Episode.star"
Activity115Module_pb.ACT115EPISODESTARFIELD.number = 2
Activity115Module_pb.ACT115EPISODESTARFIELD.index = 1
Activity115Module_pb.ACT115EPISODESTARFIELD.label = 1
Activity115Module_pb.ACT115EPISODESTARFIELD.has_default_value = false
Activity115Module_pb.ACT115EPISODESTARFIELD.default_value = 0
Activity115Module_pb.ACT115EPISODESTARFIELD.type = 5
Activity115Module_pb.ACT115EPISODESTARFIELD.cpp_type = 1
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.name = "totalCount"
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.full_name = ".Act115Episode.totalCount"
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.number = 3
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.index = 2
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.label = 1
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.has_default_value = false
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.default_value = 0
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.type = 5
Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD.cpp_type = 1
Activity115Module_pb.ACT115EPISODE_MSG.name = "Act115Episode"
Activity115Module_pb.ACT115EPISODE_MSG.full_name = ".Act115Episode"
Activity115Module_pb.ACT115EPISODE_MSG.nested_types = {}
Activity115Module_pb.ACT115EPISODE_MSG.enum_types = {}
Activity115Module_pb.ACT115EPISODE_MSG.fields = {
	Activity115Module_pb.ACT115EPISODEIDFIELD,
	Activity115Module_pb.ACT115EPISODESTARFIELD,
	Activity115Module_pb.ACT115EPISODETOTALCOUNTFIELD
}
Activity115Module_pb.ACT115EPISODE_MSG.is_extendable = false
Activity115Module_pb.ACT115EPISODE_MSG.extensions = {}
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.full_name = ".Act115StepPush.activityId"
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.name = "steps"
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.full_name = ".Act115StepPush.steps"
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.number = 2
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.index = 1
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.label = 3
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.has_default_value = false
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.default_value = {}
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.message_type = Activity115Module_pb.ACT115STEP_MSG
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.type = 11
Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD.cpp_type = 10
Activity115Module_pb.ACT115STEPPUSH_MSG.name = "Act115StepPush"
Activity115Module_pb.ACT115STEPPUSH_MSG.full_name = ".Act115StepPush"
Activity115Module_pb.ACT115STEPPUSH_MSG.nested_types = {}
Activity115Module_pb.ACT115STEPPUSH_MSG.enum_types = {}
Activity115Module_pb.ACT115STEPPUSH_MSG.fields = {
	Activity115Module_pb.ACT115STEPPUSHACTIVITYIDFIELD,
	Activity115Module_pb.ACT115STEPPUSHSTEPSFIELD
}
Activity115Module_pb.ACT115STEPPUSH_MSG.is_extendable = false
Activity115Module_pb.ACT115STEPPUSH_MSG.extensions = {}
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.full_name = ".Act115EventEndRequest.activityId"
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.name = "Act115EventEndRequest"
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.full_name = ".Act115EventEndRequest"
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115EVENTENDREQUESTACTIVITYIDFIELD
}
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115EVENTENDREQUEST_MSG.extensions = {}
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.full_name = ".Act115BonusRequest.activityId"
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115BONUSREQUEST_MSG.name = "Act115BonusRequest"
Activity115Module_pb.ACT115BONUSREQUEST_MSG.full_name = ".Act115BonusRequest"
Activity115Module_pb.ACT115BONUSREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115BONUSREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115BONUSREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115BONUSREQUESTACTIVITYIDFIELD
}
Activity115Module_pb.ACT115BONUSREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115BONUSREQUEST_MSG.extensions = {}
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.full_name = ".Act115UseSkillReply.activityId"
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.name = "interactObject"
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.full_name = ".Act115UseSkillReply.interactObject"
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.number = 2
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.index = 1
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.label = 1
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.has_default_value = false
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.default_value = nil
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.message_type = Activity115Module_pb.ACT115INTERACTOBJECT_MSG
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.type = 11
Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD.cpp_type = 10
Activity115Module_pb.ACT115USESKILLREPLY_MSG.name = "Act115UseSkillReply"
Activity115Module_pb.ACT115USESKILLREPLY_MSG.full_name = ".Act115UseSkillReply"
Activity115Module_pb.ACT115USESKILLREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115USESKILLREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115USESKILLREPLY_MSG.fields = {
	Activity115Module_pb.ACT115USESKILLREPLYACTIVITYIDFIELD,
	Activity115Module_pb.ACT115USESKILLREPLYINTERACTOBJECTFIELD
}
Activity115Module_pb.ACT115USESKILLREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115USESKILLREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.full_name = ".Act115BeginRoundRequest.activityId"
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.name = "operations"
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.full_name = ".Act115BeginRoundRequest.operations"
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.number = 2
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.index = 1
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.label = 3
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.has_default_value = false
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.default_value = {}
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.message_type = Activity115Module_pb.ACT115OPERATION_MSG
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.type = 11
Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD.cpp_type = 10
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.name = "Act115BeginRoundRequest"
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.full_name = ".Act115BeginRoundRequest"
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115BEGINROUNDREQUESTACTIVITYIDFIELD,
	Activity115Module_pb.ACT115BEGINROUNDREQUESTOPERATIONSFIELD
}
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG.extensions = {}
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.full_name = ".Act115EventEndReply.activityId"
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.name = "Act115EventEndReply"
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.full_name = ".Act115EventEndReply"
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.fields = {
	Activity115Module_pb.ACT115EVENTENDREPLYACTIVITYIDFIELD
}
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115EVENTENDREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.full_name = ".Act115BonusReply.activityId"
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.full_name = ".Act115BonusReply.hasGetBonusIds"
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.number = 2
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.index = 1
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.label = 3
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.has_default_value = false
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.default_value = {}
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.type = 5
Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD.cpp_type = 1
Activity115Module_pb.ACT115BONUSREPLY_MSG.name = "Act115BonusReply"
Activity115Module_pb.ACT115BONUSREPLY_MSG.full_name = ".Act115BonusReply"
Activity115Module_pb.ACT115BONUSREPLY_MSG.nested_types = {}
Activity115Module_pb.ACT115BONUSREPLY_MSG.enum_types = {}
Activity115Module_pb.ACT115BONUSREPLY_MSG.fields = {
	Activity115Module_pb.ACT115BONUSREPLYACTIVITYIDFIELD,
	Activity115Module_pb.ACT115BONUSREPLYHASGETBONUSIDSFIELD
}
Activity115Module_pb.ACT115BONUSREPLY_MSG.is_extendable = false
Activity115Module_pb.ACT115BONUSREPLY_MSG.extensions = {}
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.name = "id"
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.full_name = ".Act115InteractObject.id"
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.number = 1
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.index = 0
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.label = 1
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.has_default_value = false
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.default_value = 0
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.type = 5
Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.name = "x"
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.full_name = ".Act115InteractObject.x"
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.number = 2
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.index = 1
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.label = 1
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.has_default_value = false
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.default_value = 0
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.type = 5
Activity115Module_pb.ACT115INTERACTOBJECTXFIELD.cpp_type = 1
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.name = "y"
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.full_name = ".Act115InteractObject.y"
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.number = 3
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.index = 2
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.label = 1
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.has_default_value = false
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.default_value = 0
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.type = 5
Activity115Module_pb.ACT115INTERACTOBJECTYFIELD.cpp_type = 1
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.name = "direction"
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.full_name = ".Act115InteractObject.direction"
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.number = 4
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.index = 3
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.label = 1
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.has_default_value = false
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.default_value = 0
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.type = 5
Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD.cpp_type = 1
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.name = "data"
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.full_name = ".Act115InteractObject.data"
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.number = 5
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.index = 4
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.label = 1
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.has_default_value = false
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.default_value = ""
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.type = 9
Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD.cpp_type = 9
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.name = "Act115InteractObject"
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.full_name = ".Act115InteractObject"
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.nested_types = {}
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.enum_types = {}
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.fields = {
	Activity115Module_pb.ACT115INTERACTOBJECTIDFIELD,
	Activity115Module_pb.ACT115INTERACTOBJECTXFIELD,
	Activity115Module_pb.ACT115INTERACTOBJECTYFIELD,
	Activity115Module_pb.ACT115INTERACTOBJECTDIRECTIONFIELD,
	Activity115Module_pb.ACT115INTERACTOBJECTDATAFIELD
}
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.is_extendable = false
Activity115Module_pb.ACT115INTERACTOBJECT_MSG.extensions = {}
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.full_name = ".Act115RevertRequest.activityId"
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.number = 1
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.index = 0
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.label = 1
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.default_value = 0
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.type = 5
Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity115Module_pb.ACT115REVERTREQUEST_MSG.name = "Act115RevertRequest"
Activity115Module_pb.ACT115REVERTREQUEST_MSG.full_name = ".Act115RevertRequest"
Activity115Module_pb.ACT115REVERTREQUEST_MSG.nested_types = {}
Activity115Module_pb.ACT115REVERTREQUEST_MSG.enum_types = {}
Activity115Module_pb.ACT115REVERTREQUEST_MSG.fields = {
	Activity115Module_pb.ACT115REVERTREQUESTACTIVITYIDFIELD
}
Activity115Module_pb.ACT115REVERTREQUEST_MSG.is_extendable = false
Activity115Module_pb.ACT115REVERTREQUEST_MSG.extensions = {}
Activity115Module_pb.Act115AbortReply = protobuf.Message(Activity115Module_pb.ACT115ABORTREPLY_MSG)
Activity115Module_pb.Act115AbortRequest = protobuf.Message(Activity115Module_pb.ACT115ABORTREQUEST_MSG)
Activity115Module_pb.Act115BeginRoundReply = protobuf.Message(Activity115Module_pb.ACT115BEGINROUNDREPLY_MSG)
Activity115Module_pb.Act115BeginRoundRequest = protobuf.Message(Activity115Module_pb.ACT115BEGINROUNDREQUEST_MSG)
Activity115Module_pb.Act115BonusReply = protobuf.Message(Activity115Module_pb.ACT115BONUSREPLY_MSG)
Activity115Module_pb.Act115BonusRequest = protobuf.Message(Activity115Module_pb.ACT115BONUSREQUEST_MSG)
Activity115Module_pb.Act115Episode = protobuf.Message(Activity115Module_pb.ACT115EPISODE_MSG)
Activity115Module_pb.Act115Event = protobuf.Message(Activity115Module_pb.ACT115EVENT_MSG)
Activity115Module_pb.Act115EventEndReply = protobuf.Message(Activity115Module_pb.ACT115EVENTENDREPLY_MSG)
Activity115Module_pb.Act115EventEndRequest = protobuf.Message(Activity115Module_pb.ACT115EVENTENDREQUEST_MSG)
Activity115Module_pb.Act115InteractObject = protobuf.Message(Activity115Module_pb.ACT115INTERACTOBJECT_MSG)
Activity115Module_pb.Act115Map = protobuf.Message(Activity115Module_pb.ACT115MAP_MSG)
Activity115Module_pb.Act115Operation = protobuf.Message(Activity115Module_pb.ACT115OPERATION_MSG)
Activity115Module_pb.Act115RevertReply = protobuf.Message(Activity115Module_pb.ACT115REVERTREPLY_MSG)
Activity115Module_pb.Act115RevertRequest = protobuf.Message(Activity115Module_pb.ACT115REVERTREQUEST_MSG)
Activity115Module_pb.Act115StartEpisodeReply = protobuf.Message(Activity115Module_pb.ACT115STARTEPISODEREPLY_MSG)
Activity115Module_pb.Act115StartEpisodeRequest = protobuf.Message(Activity115Module_pb.ACT115STARTEPISODEREQUEST_MSG)
Activity115Module_pb.Act115Step = protobuf.Message(Activity115Module_pb.ACT115STEP_MSG)
Activity115Module_pb.Act115StepPush = protobuf.Message(Activity115Module_pb.ACT115STEPPUSH_MSG)
Activity115Module_pb.Act115UseSkillReply = protobuf.Message(Activity115Module_pb.ACT115USESKILLREPLY_MSG)
Activity115Module_pb.Act115UseSkillRequest = protobuf.Message(Activity115Module_pb.ACT115USESKILLREQUEST_MSG)
Activity115Module_pb.GetAct115InfoReply = protobuf.Message(Activity115Module_pb.GETACT115INFOREPLY_MSG)
Activity115Module_pb.GetAct115InfoRequest = protobuf.Message(Activity115Module_pb.GETACT115INFOREQUEST_MSG)

return Activity115Module_pb
