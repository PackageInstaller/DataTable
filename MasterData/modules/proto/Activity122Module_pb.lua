-- chunkname: @modules/proto/Activity122Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity122Module_pb", package.seeall)

local Activity122Module_pb = {}

Activity122Module_pb.ACT122MAP_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122MAPIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPMAPIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPHPFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPACT122FIREFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPTARGETNUMFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122OPERATION_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122OPERATIONIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122ABORTREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.GETACT122INFOSREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122USEITEMREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122USEITEMREPLYXFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122USEITEMREPLYYFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122INTERACTOBJECT_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STEPPUSH_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122EPISODE_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122EPISODEIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122EPISODESTARFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122EVENTENDREPLY_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122USEITEMREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122EVENT_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122EVENTPARAMFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122ABORTREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122STEP_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122STEPPARAMFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122SIGHT_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122SIGHTXFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122SIGHTYFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122FIRE_MSG = protobuf.Descriptor()
Activity122Module_pb.ACT122FIREXFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122FIREYFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.GETACT122INFOSREQUEST_MSG = protobuf.Descriptor()
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity122Module_pb.ACT122MAPIDFIELD.name = "id"
Activity122Module_pb.ACT122MAPIDFIELD.full_name = ".Act122Map.id"
Activity122Module_pb.ACT122MAPIDFIELD.number = 1
Activity122Module_pb.ACT122MAPIDFIELD.index = 0
Activity122Module_pb.ACT122MAPIDFIELD.label = 1
Activity122Module_pb.ACT122MAPIDFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPIDFIELD.default_value = 0
Activity122Module_pb.ACT122MAPIDFIELD.type = 5
Activity122Module_pb.ACT122MAPIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAPMAPIDFIELD.name = "mapId"
Activity122Module_pb.ACT122MAPMAPIDFIELD.full_name = ".Act122Map.mapId"
Activity122Module_pb.ACT122MAPMAPIDFIELD.number = 2
Activity122Module_pb.ACT122MAPMAPIDFIELD.index = 1
Activity122Module_pb.ACT122MAPMAPIDFIELD.label = 1
Activity122Module_pb.ACT122MAPMAPIDFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPMAPIDFIELD.default_value = 0
Activity122Module_pb.ACT122MAPMAPIDFIELD.type = 5
Activity122Module_pb.ACT122MAPMAPIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.name = "interactObjects"
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.full_name = ".Act122Map.interactObjects"
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.number = 3
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.index = 2
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.label = 3
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.default_value = {}
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.message_type = Activity122Module_pb.ACT122INTERACTOBJECT_MSG
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.type = 11
Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD.cpp_type = 10
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.name = "currentEvent"
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.full_name = ".Act122Map.currentEvent"
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.number = 4
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.index = 3
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.label = 1
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.default_value = nil
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.message_type = Activity122Module_pb.ACT122EVENT_MSG
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.type = 11
Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD.cpp_type = 10
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.name = "currentRound"
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.full_name = ".Act122Map.currentRound"
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.number = 5
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.index = 4
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.label = 1
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.default_value = 0
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.type = 5
Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.name = "finishInteracts"
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.full_name = ".Act122Map.finishInteracts"
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.number = 6
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.index = 5
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.label = 3
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.default_value = {}
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.type = 5
Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.name = "allFinishInteracts"
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.full_name = ".Act122Map.allFinishInteracts"
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.number = 7
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.index = 6
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.label = 3
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.default_value = {}
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.type = 5
Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAPHPFIELD.name = "hp"
Activity122Module_pb.ACT122MAPHPFIELD.full_name = ".Act122Map.hp"
Activity122Module_pb.ACT122MAPHPFIELD.number = 8
Activity122Module_pb.ACT122MAPHPFIELD.index = 7
Activity122Module_pb.ACT122MAPHPFIELD.label = 1
Activity122Module_pb.ACT122MAPHPFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPHPFIELD.default_value = 0
Activity122Module_pb.ACT122MAPHPFIELD.type = 5
Activity122Module_pb.ACT122MAPHPFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.name = "act122Sight"
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.full_name = ".Act122Map.act122Sight"
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.number = 9
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.index = 8
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.label = 3
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.default_value = {}
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.message_type = Activity122Module_pb.ACT122SIGHT_MSG
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.type = 11
Activity122Module_pb.ACT122MAPACT122SIGHTFIELD.cpp_type = 10
Activity122Module_pb.ACT122MAPACT122FIREFIELD.name = "act122Fire"
Activity122Module_pb.ACT122MAPACT122FIREFIELD.full_name = ".Act122Map.act122Fire"
Activity122Module_pb.ACT122MAPACT122FIREFIELD.number = 10
Activity122Module_pb.ACT122MAPACT122FIREFIELD.index = 9
Activity122Module_pb.ACT122MAPACT122FIREFIELD.label = 3
Activity122Module_pb.ACT122MAPACT122FIREFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPACT122FIREFIELD.default_value = {}
Activity122Module_pb.ACT122MAPACT122FIREFIELD.message_type = Activity122Module_pb.ACT122FIRE_MSG
Activity122Module_pb.ACT122MAPACT122FIREFIELD.type = 11
Activity122Module_pb.ACT122MAPACT122FIREFIELD.cpp_type = 10
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.name = "targetNum"
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.full_name = ".Act122Map.targetNum"
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.number = 11
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.index = 10
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.label = 1
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.has_default_value = false
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.default_value = 0
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.type = 5
Activity122Module_pb.ACT122MAPTARGETNUMFIELD.cpp_type = 1
Activity122Module_pb.ACT122MAP_MSG.name = "Act122Map"
Activity122Module_pb.ACT122MAP_MSG.full_name = ".Act122Map"
Activity122Module_pb.ACT122MAP_MSG.nested_types = {}
Activity122Module_pb.ACT122MAP_MSG.enum_types = {}
Activity122Module_pb.ACT122MAP_MSG.fields = {
	Activity122Module_pb.ACT122MAPIDFIELD,
	Activity122Module_pb.ACT122MAPMAPIDFIELD,
	Activity122Module_pb.ACT122MAPINTERACTOBJECTSFIELD,
	Activity122Module_pb.ACT122MAPCURRENTEVENTFIELD,
	Activity122Module_pb.ACT122MAPCURRENTROUNDFIELD,
	Activity122Module_pb.ACT122MAPFINISHINTERACTSFIELD,
	Activity122Module_pb.ACT122MAPALLFINISHINTERACTSFIELD,
	Activity122Module_pb.ACT122MAPHPFIELD,
	Activity122Module_pb.ACT122MAPACT122SIGHTFIELD,
	Activity122Module_pb.ACT122MAPACT122FIREFIELD,
	Activity122Module_pb.ACT122MAPTARGETNUMFIELD
}
Activity122Module_pb.ACT122MAP_MSG.is_extendable = false
Activity122Module_pb.ACT122MAP_MSG.extensions = {}
Activity122Module_pb.ACT122OPERATIONIDFIELD.name = "id"
Activity122Module_pb.ACT122OPERATIONIDFIELD.full_name = ".Act122Operation.id"
Activity122Module_pb.ACT122OPERATIONIDFIELD.number = 1
Activity122Module_pb.ACT122OPERATIONIDFIELD.index = 0
Activity122Module_pb.ACT122OPERATIONIDFIELD.label = 1
Activity122Module_pb.ACT122OPERATIONIDFIELD.has_default_value = false
Activity122Module_pb.ACT122OPERATIONIDFIELD.default_value = 0
Activity122Module_pb.ACT122OPERATIONIDFIELD.type = 5
Activity122Module_pb.ACT122OPERATIONIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.name = "moveDirection"
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.full_name = ".Act122Operation.moveDirection"
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.number = 2
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.index = 1
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.label = 1
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.has_default_value = false
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.default_value = 0
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.type = 5
Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD.cpp_type = 1
Activity122Module_pb.ACT122OPERATION_MSG.name = "Act122Operation"
Activity122Module_pb.ACT122OPERATION_MSG.full_name = ".Act122Operation"
Activity122Module_pb.ACT122OPERATION_MSG.nested_types = {}
Activity122Module_pb.ACT122OPERATION_MSG.enum_types = {}
Activity122Module_pb.ACT122OPERATION_MSG.fields = {
	Activity122Module_pb.ACT122OPERATIONIDFIELD,
	Activity122Module_pb.ACT122OPERATIONMOVEDIRECTIONFIELD
}
Activity122Module_pb.ACT122OPERATION_MSG.is_extendable = false
Activity122Module_pb.ACT122OPERATION_MSG.extensions = {}
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.full_name = ".Act122EventEndRequest.activityId"
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.name = "Act122EventEndRequest"
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.full_name = ".Act122EventEndRequest"
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.nested_types = {}
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.enum_types = {}
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.fields = {
	Activity122Module_pb.ACT122EVENTENDREQUESTACTIVITYIDFIELD
}
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.is_extendable = false
Activity122Module_pb.ACT122EVENTENDREQUEST_MSG.extensions = {}
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.full_name = ".Act122AbortReply.activityId"
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122ABORTREPLY_MSG.name = "Act122AbortReply"
Activity122Module_pb.ACT122ABORTREPLY_MSG.full_name = ".Act122AbortReply"
Activity122Module_pb.ACT122ABORTREPLY_MSG.nested_types = {}
Activity122Module_pb.ACT122ABORTREPLY_MSG.enum_types = {}
Activity122Module_pb.ACT122ABORTREPLY_MSG.fields = {
	Activity122Module_pb.ACT122ABORTREPLYACTIVITYIDFIELD
}
Activity122Module_pb.ACT122ABORTREPLY_MSG.is_extendable = false
Activity122Module_pb.ACT122ABORTREPLY_MSG.extensions = {}
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.full_name = ".Act122CheckPointReply.activityId"
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.name = "map"
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.full_name = ".Act122CheckPointReply.map"
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.number = 2
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.index = 1
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.label = 1
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.has_default_value = false
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.default_value = nil
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.message_type = Activity122Module_pb.ACT122MAP_MSG
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.type = 11
Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD.cpp_type = 10
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.name = "Act122CheckPointReply"
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.full_name = ".Act122CheckPointReply"
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.nested_types = {}
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.enum_types = {}
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.fields = {
	Activity122Module_pb.ACT122CHECKPOINTREPLYACTIVITYIDFIELD,
	Activity122Module_pb.ACT122CHECKPOINTREPLYMAPFIELD
}
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.is_extendable = false
Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG.extensions = {}
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.full_name = ".Act122BeginRoundReply.activityId"
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.name = "operations"
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.full_name = ".Act122BeginRoundReply.operations"
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.number = 2
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.index = 1
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.label = 3
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.has_default_value = false
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.default_value = {}
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.message_type = Activity122Module_pb.ACT122OPERATION_MSG
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.type = 11
Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD.cpp_type = 10
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.name = "Act122BeginRoundReply"
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.full_name = ".Act122BeginRoundReply"
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.nested_types = {}
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.enum_types = {}
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.fields = {
	Activity122Module_pb.ACT122BEGINROUNDREPLYACTIVITYIDFIELD,
	Activity122Module_pb.ACT122BEGINROUNDREPLYOPERATIONSFIELD
}
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.is_extendable = false
Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG.extensions = {}
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.full_name = ".Act122StartEpisodeReply.activityId"
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.name = "map"
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.full_name = ".Act122StartEpisodeReply.map"
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.number = 2
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.index = 1
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.label = 1
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.has_default_value = false
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.default_value = nil
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.message_type = Activity122Module_pb.ACT122MAP_MSG
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.type = 11
Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD.cpp_type = 10
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.name = "Act122StartEpisodeReply"
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.full_name = ".Act122StartEpisodeReply"
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.nested_types = {}
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.enum_types = {}
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.fields = {
	Activity122Module_pb.ACT122STARTEPISODEREPLYACTIVITYIDFIELD,
	Activity122Module_pb.ACT122STARTEPISODEREPLYMAPFIELD
}
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.is_extendable = false
Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG.extensions = {}
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.full_name = ".GetAct122InfosReply.activityId"
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.name = "map"
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.full_name = ".GetAct122InfosReply.map"
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.number = 2
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.index = 1
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.label = 1
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.has_default_value = false
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.default_value = nil
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.message_type = Activity122Module_pb.ACT122MAP_MSG
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.type = 11
Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD.cpp_type = 10
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.name = "act122Episodes"
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.full_name = ".GetAct122InfosReply.act122Episodes"
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.number = 3
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.index = 2
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.label = 3
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.has_default_value = false
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.default_value = {}
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.message_type = Activity122Module_pb.ACT122EPISODE_MSG
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.type = 11
Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD.cpp_type = 10
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.name = "lastEpisodeId"
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.full_name = ".GetAct122InfosReply.lastEpisodeId"
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.number = 4
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.index = 3
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.label = 1
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.has_default_value = false
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.default_value = 0
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.type = 5
Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD.cpp_type = 1
Activity122Module_pb.GETACT122INFOSREPLY_MSG.name = "GetAct122InfosReply"
Activity122Module_pb.GETACT122INFOSREPLY_MSG.full_name = ".GetAct122InfosReply"
Activity122Module_pb.GETACT122INFOSREPLY_MSG.nested_types = {}
Activity122Module_pb.GETACT122INFOSREPLY_MSG.enum_types = {}
Activity122Module_pb.GETACT122INFOSREPLY_MSG.fields = {
	Activity122Module_pb.GETACT122INFOSREPLYACTIVITYIDFIELD,
	Activity122Module_pb.GETACT122INFOSREPLYMAPFIELD,
	Activity122Module_pb.GETACT122INFOSREPLYACT122EPISODESFIELD,
	Activity122Module_pb.GETACT122INFOSREPLYLASTEPISODEIDFIELD
}
Activity122Module_pb.GETACT122INFOSREPLY_MSG.is_extendable = false
Activity122Module_pb.GETACT122INFOSREPLY_MSG.extensions = {}
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.full_name = ".Act122BeginRoundRequest.activityId"
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.name = "operations"
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.full_name = ".Act122BeginRoundRequest.operations"
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.number = 2
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.index = 1
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.label = 3
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.has_default_value = false
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.default_value = {}
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.message_type = Activity122Module_pb.ACT122OPERATION_MSG
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.type = 11
Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD.cpp_type = 10
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.name = "Act122BeginRoundRequest"
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.full_name = ".Act122BeginRoundRequest"
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.nested_types = {}
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.enum_types = {}
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.fields = {
	Activity122Module_pb.ACT122BEGINROUNDREQUESTACTIVITYIDFIELD,
	Activity122Module_pb.ACT122BEGINROUNDREQUESTOPERATIONSFIELD
}
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.is_extendable = false
Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG.extensions = {}
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.full_name = ".Act122UseItemReply.activityId"
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.name = "x"
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.full_name = ".Act122UseItemReply.x"
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.number = 2
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.index = 1
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.label = 1
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.has_default_value = false
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.default_value = 0
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.type = 5
Activity122Module_pb.ACT122USEITEMREPLYXFIELD.cpp_type = 1
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.name = "y"
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.full_name = ".Act122UseItemReply.y"
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.number = 3
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.index = 2
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.label = 1
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.has_default_value = false
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.default_value = 0
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.type = 5
Activity122Module_pb.ACT122USEITEMREPLYYFIELD.cpp_type = 1
Activity122Module_pb.ACT122USEITEMREPLY_MSG.name = "Act122UseItemReply"
Activity122Module_pb.ACT122USEITEMREPLY_MSG.full_name = ".Act122UseItemReply"
Activity122Module_pb.ACT122USEITEMREPLY_MSG.nested_types = {}
Activity122Module_pb.ACT122USEITEMREPLY_MSG.enum_types = {}
Activity122Module_pb.ACT122USEITEMREPLY_MSG.fields = {
	Activity122Module_pb.ACT122USEITEMREPLYACTIVITYIDFIELD,
	Activity122Module_pb.ACT122USEITEMREPLYXFIELD,
	Activity122Module_pb.ACT122USEITEMREPLYYFIELD
}
Activity122Module_pb.ACT122USEITEMREPLY_MSG.is_extendable = false
Activity122Module_pb.ACT122USEITEMREPLY_MSG.extensions = {}
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.name = "id"
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.full_name = ".Act122InteractObject.id"
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.number = 1
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.index = 0
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.label = 1
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.has_default_value = false
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.default_value = 0
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.type = 5
Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.name = "x"
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.full_name = ".Act122InteractObject.x"
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.number = 2
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.index = 1
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.label = 1
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.has_default_value = false
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.default_value = 0
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.type = 5
Activity122Module_pb.ACT122INTERACTOBJECTXFIELD.cpp_type = 1
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.name = "y"
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.full_name = ".Act122InteractObject.y"
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.number = 3
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.index = 2
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.label = 1
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.has_default_value = false
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.default_value = 0
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.type = 5
Activity122Module_pb.ACT122INTERACTOBJECTYFIELD.cpp_type = 1
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.name = "data"
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.full_name = ".Act122InteractObject.data"
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.number = 4
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.index = 3
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.label = 1
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.has_default_value = false
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.default_value = ""
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.type = 9
Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD.cpp_type = 9
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.name = "direction"
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.full_name = ".Act122InteractObject.direction"
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.number = 5
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.index = 4
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.label = 1
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.has_default_value = false
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.default_value = 0
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.type = 5
Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD.cpp_type = 1
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.name = "Act122InteractObject"
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.full_name = ".Act122InteractObject"
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.nested_types = {}
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.enum_types = {}
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.fields = {
	Activity122Module_pb.ACT122INTERACTOBJECTIDFIELD,
	Activity122Module_pb.ACT122INTERACTOBJECTXFIELD,
	Activity122Module_pb.ACT122INTERACTOBJECTYFIELD,
	Activity122Module_pb.ACT122INTERACTOBJECTDATAFIELD,
	Activity122Module_pb.ACT122INTERACTOBJECTDIRECTIONFIELD
}
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.is_extendable = false
Activity122Module_pb.ACT122INTERACTOBJECT_MSG.extensions = {}
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.full_name = ".Act122StartEpisodeRequest.activityId"
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.name = "id"
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.full_name = ".Act122StartEpisodeRequest.id"
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.number = 2
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.index = 1
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.label = 1
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.has_default_value = false
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.default_value = 0
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.type = 5
Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.name = "Act122StartEpisodeRequest"
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.full_name = ".Act122StartEpisodeRequest"
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.nested_types = {}
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.enum_types = {}
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.fields = {
	Activity122Module_pb.ACT122STARTEPISODEREQUESTACTIVITYIDFIELD,
	Activity122Module_pb.ACT122STARTEPISODEREQUESTIDFIELD
}
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.is_extendable = false
Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG.extensions = {}
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.full_name = ".Act122StepPush.activityId"
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.name = "steps"
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.full_name = ".Act122StepPush.steps"
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.number = 2
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.index = 1
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.label = 3
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.has_default_value = false
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.default_value = {}
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.message_type = Activity122Module_pb.ACT122STEP_MSG
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.type = 11
Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD.cpp_type = 10
Activity122Module_pb.ACT122STEPPUSH_MSG.name = "Act122StepPush"
Activity122Module_pb.ACT122STEPPUSH_MSG.full_name = ".Act122StepPush"
Activity122Module_pb.ACT122STEPPUSH_MSG.nested_types = {}
Activity122Module_pb.ACT122STEPPUSH_MSG.enum_types = {}
Activity122Module_pb.ACT122STEPPUSH_MSG.fields = {
	Activity122Module_pb.ACT122STEPPUSHACTIVITYIDFIELD,
	Activity122Module_pb.ACT122STEPPUSHSTEPSFIELD
}
Activity122Module_pb.ACT122STEPPUSH_MSG.is_extendable = false
Activity122Module_pb.ACT122STEPPUSH_MSG.extensions = {}
Activity122Module_pb.ACT122EPISODEIDFIELD.name = "id"
Activity122Module_pb.ACT122EPISODEIDFIELD.full_name = ".Act122Episode.id"
Activity122Module_pb.ACT122EPISODEIDFIELD.number = 1
Activity122Module_pb.ACT122EPISODEIDFIELD.index = 0
Activity122Module_pb.ACT122EPISODEIDFIELD.label = 1
Activity122Module_pb.ACT122EPISODEIDFIELD.has_default_value = false
Activity122Module_pb.ACT122EPISODEIDFIELD.default_value = 0
Activity122Module_pb.ACT122EPISODEIDFIELD.type = 5
Activity122Module_pb.ACT122EPISODEIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122EPISODESTARFIELD.name = "star"
Activity122Module_pb.ACT122EPISODESTARFIELD.full_name = ".Act122Episode.star"
Activity122Module_pb.ACT122EPISODESTARFIELD.number = 2
Activity122Module_pb.ACT122EPISODESTARFIELD.index = 1
Activity122Module_pb.ACT122EPISODESTARFIELD.label = 1
Activity122Module_pb.ACT122EPISODESTARFIELD.has_default_value = false
Activity122Module_pb.ACT122EPISODESTARFIELD.default_value = 0
Activity122Module_pb.ACT122EPISODESTARFIELD.type = 5
Activity122Module_pb.ACT122EPISODESTARFIELD.cpp_type = 1
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.name = "totalCount"
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.full_name = ".Act122Episode.totalCount"
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.number = 3
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.index = 2
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.label = 1
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.has_default_value = false
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.default_value = 0
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.type = 5
Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD.cpp_type = 1
Activity122Module_pb.ACT122EPISODE_MSG.name = "Act122Episode"
Activity122Module_pb.ACT122EPISODE_MSG.full_name = ".Act122Episode"
Activity122Module_pb.ACT122EPISODE_MSG.nested_types = {}
Activity122Module_pb.ACT122EPISODE_MSG.enum_types = {}
Activity122Module_pb.ACT122EPISODE_MSG.fields = {
	Activity122Module_pb.ACT122EPISODEIDFIELD,
	Activity122Module_pb.ACT122EPISODESTARFIELD,
	Activity122Module_pb.ACT122EPISODETOTALCOUNTFIELD
}
Activity122Module_pb.ACT122EPISODE_MSG.is_extendable = false
Activity122Module_pb.ACT122EPISODE_MSG.extensions = {}
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.full_name = ".Act122EventEndReply.activityId"
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.name = "Act122EventEndReply"
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.full_name = ".Act122EventEndReply"
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.nested_types = {}
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.enum_types = {}
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.fields = {
	Activity122Module_pb.ACT122EVENTENDREPLYACTIVITYIDFIELD
}
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.is_extendable = false
Activity122Module_pb.ACT122EVENTENDREPLY_MSG.extensions = {}
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.full_name = ".Act122UseItemRequest.activityId"
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.name = "x"
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.full_name = ".Act122UseItemRequest.x"
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.number = 2
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.index = 1
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.label = 1
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.has_default_value = false
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.default_value = 0
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.type = 5
Activity122Module_pb.ACT122USEITEMREQUESTXFIELD.cpp_type = 1
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.name = "y"
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.full_name = ".Act122UseItemRequest.y"
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.number = 3
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.index = 2
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.label = 1
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.has_default_value = false
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.default_value = 0
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.type = 5
Activity122Module_pb.ACT122USEITEMREQUESTYFIELD.cpp_type = 1
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.name = "Act122UseItemRequest"
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.full_name = ".Act122UseItemRequest"
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.nested_types = {}
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.enum_types = {}
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.fields = {
	Activity122Module_pb.ACT122USEITEMREQUESTACTIVITYIDFIELD,
	Activity122Module_pb.ACT122USEITEMREQUESTXFIELD,
	Activity122Module_pb.ACT122USEITEMREQUESTYFIELD
}
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.is_extendable = false
Activity122Module_pb.ACT122USEITEMREQUEST_MSG.extensions = {}
Activity122Module_pb.ACT122EVENTPARAMFIELD.name = "param"
Activity122Module_pb.ACT122EVENTPARAMFIELD.full_name = ".Act122Event.param"
Activity122Module_pb.ACT122EVENTPARAMFIELD.number = 1
Activity122Module_pb.ACT122EVENTPARAMFIELD.index = 0
Activity122Module_pb.ACT122EVENTPARAMFIELD.label = 1
Activity122Module_pb.ACT122EVENTPARAMFIELD.has_default_value = false
Activity122Module_pb.ACT122EVENTPARAMFIELD.default_value = ""
Activity122Module_pb.ACT122EVENTPARAMFIELD.type = 9
Activity122Module_pb.ACT122EVENTPARAMFIELD.cpp_type = 9
Activity122Module_pb.ACT122EVENT_MSG.name = "Act122Event"
Activity122Module_pb.ACT122EVENT_MSG.full_name = ".Act122Event"
Activity122Module_pb.ACT122EVENT_MSG.nested_types = {}
Activity122Module_pb.ACT122EVENT_MSG.enum_types = {}
Activity122Module_pb.ACT122EVENT_MSG.fields = {
	Activity122Module_pb.ACT122EVENTPARAMFIELD
}
Activity122Module_pb.ACT122EVENT_MSG.is_extendable = false
Activity122Module_pb.ACT122EVENT_MSG.extensions = {}
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.full_name = ".Act122AbortRequest.activityId"
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122ABORTREQUEST_MSG.name = "Act122AbortRequest"
Activity122Module_pb.ACT122ABORTREQUEST_MSG.full_name = ".Act122AbortRequest"
Activity122Module_pb.ACT122ABORTREQUEST_MSG.nested_types = {}
Activity122Module_pb.ACT122ABORTREQUEST_MSG.enum_types = {}
Activity122Module_pb.ACT122ABORTREQUEST_MSG.fields = {
	Activity122Module_pb.ACT122ABORTREQUESTACTIVITYIDFIELD
}
Activity122Module_pb.ACT122ABORTREQUEST_MSG.is_extendable = false
Activity122Module_pb.ACT122ABORTREQUEST_MSG.extensions = {}
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.full_name = ".Act122CheckPointRequest.activityId"
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.name = "lastCheckPoint"
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.full_name = ".Act122CheckPointRequest.lastCheckPoint"
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.number = 2
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.index = 1
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.label = 1
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.has_default_value = false
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.default_value = false
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.type = 8
Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD.cpp_type = 7
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.name = "Act122CheckPointRequest"
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.full_name = ".Act122CheckPointRequest"
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.nested_types = {}
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.enum_types = {}
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.fields = {
	Activity122Module_pb.ACT122CHECKPOINTREQUESTACTIVITYIDFIELD,
	Activity122Module_pb.ACT122CHECKPOINTREQUESTLASTCHECKPOINTFIELD
}
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.is_extendable = false
Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG.extensions = {}
Activity122Module_pb.ACT122STEPPARAMFIELD.name = "param"
Activity122Module_pb.ACT122STEPPARAMFIELD.full_name = ".Act122Step.param"
Activity122Module_pb.ACT122STEPPARAMFIELD.number = 1
Activity122Module_pb.ACT122STEPPARAMFIELD.index = 0
Activity122Module_pb.ACT122STEPPARAMFIELD.label = 1
Activity122Module_pb.ACT122STEPPARAMFIELD.has_default_value = false
Activity122Module_pb.ACT122STEPPARAMFIELD.default_value = ""
Activity122Module_pb.ACT122STEPPARAMFIELD.type = 9
Activity122Module_pb.ACT122STEPPARAMFIELD.cpp_type = 9
Activity122Module_pb.ACT122STEP_MSG.name = "Act122Step"
Activity122Module_pb.ACT122STEP_MSG.full_name = ".Act122Step"
Activity122Module_pb.ACT122STEP_MSG.nested_types = {}
Activity122Module_pb.ACT122STEP_MSG.enum_types = {}
Activity122Module_pb.ACT122STEP_MSG.fields = {
	Activity122Module_pb.ACT122STEPPARAMFIELD
}
Activity122Module_pb.ACT122STEP_MSG.is_extendable = false
Activity122Module_pb.ACT122STEP_MSG.extensions = {}
Activity122Module_pb.ACT122SIGHTXFIELD.name = "x"
Activity122Module_pb.ACT122SIGHTXFIELD.full_name = ".Act122Sight.x"
Activity122Module_pb.ACT122SIGHTXFIELD.number = 1
Activity122Module_pb.ACT122SIGHTXFIELD.index = 0
Activity122Module_pb.ACT122SIGHTXFIELD.label = 1
Activity122Module_pb.ACT122SIGHTXFIELD.has_default_value = false
Activity122Module_pb.ACT122SIGHTXFIELD.default_value = 0
Activity122Module_pb.ACT122SIGHTXFIELD.type = 5
Activity122Module_pb.ACT122SIGHTXFIELD.cpp_type = 1
Activity122Module_pb.ACT122SIGHTYFIELD.name = "y"
Activity122Module_pb.ACT122SIGHTYFIELD.full_name = ".Act122Sight.y"
Activity122Module_pb.ACT122SIGHTYFIELD.number = 2
Activity122Module_pb.ACT122SIGHTYFIELD.index = 1
Activity122Module_pb.ACT122SIGHTYFIELD.label = 1
Activity122Module_pb.ACT122SIGHTYFIELD.has_default_value = false
Activity122Module_pb.ACT122SIGHTYFIELD.default_value = 0
Activity122Module_pb.ACT122SIGHTYFIELD.type = 5
Activity122Module_pb.ACT122SIGHTYFIELD.cpp_type = 1
Activity122Module_pb.ACT122SIGHT_MSG.name = "Act122Sight"
Activity122Module_pb.ACT122SIGHT_MSG.full_name = ".Act122Sight"
Activity122Module_pb.ACT122SIGHT_MSG.nested_types = {}
Activity122Module_pb.ACT122SIGHT_MSG.enum_types = {}
Activity122Module_pb.ACT122SIGHT_MSG.fields = {
	Activity122Module_pb.ACT122SIGHTXFIELD,
	Activity122Module_pb.ACT122SIGHTYFIELD
}
Activity122Module_pb.ACT122SIGHT_MSG.is_extendable = false
Activity122Module_pb.ACT122SIGHT_MSG.extensions = {}
Activity122Module_pb.ACT122FIREXFIELD.name = "x"
Activity122Module_pb.ACT122FIREXFIELD.full_name = ".Act122Fire.x"
Activity122Module_pb.ACT122FIREXFIELD.number = 1
Activity122Module_pb.ACT122FIREXFIELD.index = 0
Activity122Module_pb.ACT122FIREXFIELD.label = 1
Activity122Module_pb.ACT122FIREXFIELD.has_default_value = false
Activity122Module_pb.ACT122FIREXFIELD.default_value = 0
Activity122Module_pb.ACT122FIREXFIELD.type = 5
Activity122Module_pb.ACT122FIREXFIELD.cpp_type = 1
Activity122Module_pb.ACT122FIREYFIELD.name = "y"
Activity122Module_pb.ACT122FIREYFIELD.full_name = ".Act122Fire.y"
Activity122Module_pb.ACT122FIREYFIELD.number = 2
Activity122Module_pb.ACT122FIREYFIELD.index = 1
Activity122Module_pb.ACT122FIREYFIELD.label = 1
Activity122Module_pb.ACT122FIREYFIELD.has_default_value = false
Activity122Module_pb.ACT122FIREYFIELD.default_value = 0
Activity122Module_pb.ACT122FIREYFIELD.type = 5
Activity122Module_pb.ACT122FIREYFIELD.cpp_type = 1
Activity122Module_pb.ACT122FIRE_MSG.name = "Act122Fire"
Activity122Module_pb.ACT122FIRE_MSG.full_name = ".Act122Fire"
Activity122Module_pb.ACT122FIRE_MSG.nested_types = {}
Activity122Module_pb.ACT122FIRE_MSG.enum_types = {}
Activity122Module_pb.ACT122FIRE_MSG.fields = {
	Activity122Module_pb.ACT122FIREXFIELD,
	Activity122Module_pb.ACT122FIREYFIELD
}
Activity122Module_pb.ACT122FIRE_MSG.is_extendable = false
Activity122Module_pb.ACT122FIRE_MSG.extensions = {}
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.full_name = ".GetAct122InfosRequest.activityId"
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.name = "GetAct122InfosRequest"
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.full_name = ".GetAct122InfosRequest"
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.nested_types = {}
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.enum_types = {}
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.fields = {
	Activity122Module_pb.GETACT122INFOSREQUESTACTIVITYIDFIELD
}
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.is_extendable = false
Activity122Module_pb.GETACT122INFOSREQUEST_MSG.extensions = {}
Activity122Module_pb.Act122AbortReply = protobuf.Message(Activity122Module_pb.ACT122ABORTREPLY_MSG)
Activity122Module_pb.Act122AbortRequest = protobuf.Message(Activity122Module_pb.ACT122ABORTREQUEST_MSG)
Activity122Module_pb.Act122BeginRoundReply = protobuf.Message(Activity122Module_pb.ACT122BEGINROUNDREPLY_MSG)
Activity122Module_pb.Act122BeginRoundRequest = protobuf.Message(Activity122Module_pb.ACT122BEGINROUNDREQUEST_MSG)
Activity122Module_pb.Act122CheckPointReply = protobuf.Message(Activity122Module_pb.ACT122CHECKPOINTREPLY_MSG)
Activity122Module_pb.Act122CheckPointRequest = protobuf.Message(Activity122Module_pb.ACT122CHECKPOINTREQUEST_MSG)
Activity122Module_pb.Act122Episode = protobuf.Message(Activity122Module_pb.ACT122EPISODE_MSG)
Activity122Module_pb.Act122Event = protobuf.Message(Activity122Module_pb.ACT122EVENT_MSG)
Activity122Module_pb.Act122EventEndReply = protobuf.Message(Activity122Module_pb.ACT122EVENTENDREPLY_MSG)
Activity122Module_pb.Act122EventEndRequest = protobuf.Message(Activity122Module_pb.ACT122EVENTENDREQUEST_MSG)
Activity122Module_pb.Act122Fire = protobuf.Message(Activity122Module_pb.ACT122FIRE_MSG)
Activity122Module_pb.Act122InteractObject = protobuf.Message(Activity122Module_pb.ACT122INTERACTOBJECT_MSG)
Activity122Module_pb.Act122Map = protobuf.Message(Activity122Module_pb.ACT122MAP_MSG)
Activity122Module_pb.Act122Operation = protobuf.Message(Activity122Module_pb.ACT122OPERATION_MSG)
Activity122Module_pb.Act122Sight = protobuf.Message(Activity122Module_pb.ACT122SIGHT_MSG)
Activity122Module_pb.Act122StartEpisodeReply = protobuf.Message(Activity122Module_pb.ACT122STARTEPISODEREPLY_MSG)
Activity122Module_pb.Act122StartEpisodeRequest = protobuf.Message(Activity122Module_pb.ACT122STARTEPISODEREQUEST_MSG)
Activity122Module_pb.Act122Step = protobuf.Message(Activity122Module_pb.ACT122STEP_MSG)
Activity122Module_pb.Act122StepPush = protobuf.Message(Activity122Module_pb.ACT122STEPPUSH_MSG)
Activity122Module_pb.Act122UseItemReply = protobuf.Message(Activity122Module_pb.ACT122USEITEMREPLY_MSG)
Activity122Module_pb.Act122UseItemRequest = protobuf.Message(Activity122Module_pb.ACT122USEITEMREQUEST_MSG)
Activity122Module_pb.GetAct122InfosReply = protobuf.Message(Activity122Module_pb.GETACT122INFOSREPLY_MSG)
Activity122Module_pb.GetAct122InfosRequest = protobuf.Message(Activity122Module_pb.GETACT122INFOSREQUEST_MSG)

return Activity122Module_pb
