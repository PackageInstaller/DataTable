-- chunkname: @modules/proto/Activity120Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity120Module_pb", package.seeall)

local Activity120Module_pb = {}

Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120ABORTREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAP_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120MAPIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120MAPMAPIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120USEITEMREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120ABORTREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120EVENT_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120EVENTPARAMFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STEPPUSH_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120USEITEMREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120USEITEMREPLYXFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120USEITEMREPLYYFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.GETACT120INFOREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.GETACT120INFOREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120EPISODE_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120EPISODEIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120EPISODESTARFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120EVENTENDREPLY_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120INTERACTOBJECT_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120POINT_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120POINTXFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120POINTYFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120OPERATION_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120OPERATIONIDFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STEP_MSG = protobuf.Descriptor()
Activity120Module_pb.ACT120STEPPARAMFIELD = protobuf.FieldDescriptor()
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.full_name = ".Act120StartEpisodeReply.activityId"
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.name = "map"
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.full_name = ".Act120StartEpisodeReply.map"
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.number = 2
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.index = 1
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.label = 1
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.has_default_value = false
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.default_value = nil
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.message_type = Activity120Module_pb.ACT120MAP_MSG
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.type = 11
Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD.cpp_type = 10
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.name = "Act120StartEpisodeReply"
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.full_name = ".Act120StartEpisodeReply"
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.nested_types = {}
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.enum_types = {}
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.fields = {
	Activity120Module_pb.ACT120STARTEPISODEREPLYACTIVITYIDFIELD,
	Activity120Module_pb.ACT120STARTEPISODEREPLYMAPFIELD
}
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.is_extendable = false
Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG.extensions = {}
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.full_name = ".Act120AbortRequest.activityId"
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120ABORTREQUEST_MSG.name = "Act120AbortRequest"
Activity120Module_pb.ACT120ABORTREQUEST_MSG.full_name = ".Act120AbortRequest"
Activity120Module_pb.ACT120ABORTREQUEST_MSG.nested_types = {}
Activity120Module_pb.ACT120ABORTREQUEST_MSG.enum_types = {}
Activity120Module_pb.ACT120ABORTREQUEST_MSG.fields = {
	Activity120Module_pb.ACT120ABORTREQUESTACTIVITYIDFIELD
}
Activity120Module_pb.ACT120ABORTREQUEST_MSG.is_extendable = false
Activity120Module_pb.ACT120ABORTREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120MAPIDFIELD.name = "id"
Activity120Module_pb.ACT120MAPIDFIELD.full_name = ".Act120Map.id"
Activity120Module_pb.ACT120MAPIDFIELD.number = 1
Activity120Module_pb.ACT120MAPIDFIELD.index = 0
Activity120Module_pb.ACT120MAPIDFIELD.label = 1
Activity120Module_pb.ACT120MAPIDFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPIDFIELD.default_value = 0
Activity120Module_pb.ACT120MAPIDFIELD.type = 5
Activity120Module_pb.ACT120MAPIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.name = "interactObjects"
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.full_name = ".Act120Map.interactObjects"
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.number = 2
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.index = 1
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.label = 3
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.default_value = {}
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.message_type = Activity120Module_pb.ACT120INTERACTOBJECT_MSG
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.type = 11
Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD.cpp_type = 10
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.name = "currentEvent"
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.full_name = ".Act120Map.currentEvent"
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.number = 3
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.index = 2
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.label = 1
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.default_value = nil
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.message_type = Activity120Module_pb.ACT120EVENT_MSG
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.type = 11
Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD.cpp_type = 10
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.name = "currentRound"
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.full_name = ".Act120Map.currentRound"
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.number = 4
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.index = 3
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.label = 1
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.default_value = 0
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.type = 5
Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD.cpp_type = 1
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.name = "finishInteracts"
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.full_name = ".Act120Map.finishInteracts"
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.number = 5
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.index = 4
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.label = 3
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.default_value = {}
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.type = 5
Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD.cpp_type = 1
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.name = "brokenTilebases"
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.full_name = ".Act120Map.brokenTilebases"
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.number = 6
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.index = 5
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.label = 3
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.default_value = {}
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.message_type = Activity120Module_pb.ACT120POINT_MSG
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.type = 11
Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD.cpp_type = 10
Activity120Module_pb.ACT120MAPMAPIDFIELD.name = "mapId"
Activity120Module_pb.ACT120MAPMAPIDFIELD.full_name = ".Act120Map.mapId"
Activity120Module_pb.ACT120MAPMAPIDFIELD.number = 7
Activity120Module_pb.ACT120MAPMAPIDFIELD.index = 6
Activity120Module_pb.ACT120MAPMAPIDFIELD.label = 1
Activity120Module_pb.ACT120MAPMAPIDFIELD.has_default_value = false
Activity120Module_pb.ACT120MAPMAPIDFIELD.default_value = 0
Activity120Module_pb.ACT120MAPMAPIDFIELD.type = 5
Activity120Module_pb.ACT120MAPMAPIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120MAP_MSG.name = "Act120Map"
Activity120Module_pb.ACT120MAP_MSG.full_name = ".Act120Map"
Activity120Module_pb.ACT120MAP_MSG.nested_types = {}
Activity120Module_pb.ACT120MAP_MSG.enum_types = {}
Activity120Module_pb.ACT120MAP_MSG.fields = {
	Activity120Module_pb.ACT120MAPIDFIELD,
	Activity120Module_pb.ACT120MAPINTERACTOBJECTSFIELD,
	Activity120Module_pb.ACT120MAPCURRENTEVENTFIELD,
	Activity120Module_pb.ACT120MAPCURRENTROUNDFIELD,
	Activity120Module_pb.ACT120MAPFINISHINTERACTSFIELD,
	Activity120Module_pb.ACT120MAPBROKENTILEBASESFIELD,
	Activity120Module_pb.ACT120MAPMAPIDFIELD
}
Activity120Module_pb.ACT120MAP_MSG.is_extendable = false
Activity120Module_pb.ACT120MAP_MSG.extensions = {}
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.full_name = ".Act120UseItemRequest.activityId"
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.name = "x"
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.full_name = ".Act120UseItemRequest.x"
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.number = 2
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.index = 1
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.label = 1
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.has_default_value = false
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.default_value = 0
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.type = 5
Activity120Module_pb.ACT120USEITEMREQUESTXFIELD.cpp_type = 1
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.name = "y"
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.full_name = ".Act120UseItemRequest.y"
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.number = 3
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.index = 2
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.label = 1
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.has_default_value = false
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.default_value = 0
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.type = 5
Activity120Module_pb.ACT120USEITEMREQUESTYFIELD.cpp_type = 1
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.name = "Act120UseItemRequest"
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.full_name = ".Act120UseItemRequest"
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.nested_types = {}
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.enum_types = {}
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.fields = {
	Activity120Module_pb.ACT120USEITEMREQUESTACTIVITYIDFIELD,
	Activity120Module_pb.ACT120USEITEMREQUESTXFIELD,
	Activity120Module_pb.ACT120USEITEMREQUESTYFIELD
}
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.is_extendable = false
Activity120Module_pb.ACT120USEITEMREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.full_name = ".Act120CheckPointRequest.activityId"
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.name = "lastCheckPoint"
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.full_name = ".Act120CheckPointRequest.lastCheckPoint"
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.number = 2
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.index = 1
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.label = 1
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.has_default_value = false
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.default_value = false
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.type = 8
Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD.cpp_type = 7
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.name = "Act120CheckPointRequest"
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.full_name = ".Act120CheckPointRequest"
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.nested_types = {}
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.enum_types = {}
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.fields = {
	Activity120Module_pb.ACT120CHECKPOINTREQUESTACTIVITYIDFIELD,
	Activity120Module_pb.ACT120CHECKPOINTREQUESTLASTCHECKPOINTFIELD
}
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.is_extendable = false
Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.full_name = ".Act120AbortReply.activityId"
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120ABORTREPLY_MSG.name = "Act120AbortReply"
Activity120Module_pb.ACT120ABORTREPLY_MSG.full_name = ".Act120AbortReply"
Activity120Module_pb.ACT120ABORTREPLY_MSG.nested_types = {}
Activity120Module_pb.ACT120ABORTREPLY_MSG.enum_types = {}
Activity120Module_pb.ACT120ABORTREPLY_MSG.fields = {
	Activity120Module_pb.ACT120ABORTREPLYACTIVITYIDFIELD
}
Activity120Module_pb.ACT120ABORTREPLY_MSG.is_extendable = false
Activity120Module_pb.ACT120ABORTREPLY_MSG.extensions = {}
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.full_name = ".Act120CheckPointReply.activityId"
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.name = "map"
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.full_name = ".Act120CheckPointReply.map"
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.number = 2
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.index = 1
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.label = 1
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.has_default_value = false
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.default_value = nil
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.message_type = Activity120Module_pb.ACT120MAP_MSG
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.type = 11
Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD.cpp_type = 10
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.name = "Act120CheckPointReply"
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.full_name = ".Act120CheckPointReply"
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.nested_types = {}
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.enum_types = {}
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.fields = {
	Activity120Module_pb.ACT120CHECKPOINTREPLYACTIVITYIDFIELD,
	Activity120Module_pb.ACT120CHECKPOINTREPLYMAPFIELD
}
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.is_extendable = false
Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG.extensions = {}
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.full_name = ".Act120BeginRoundReply.activityId"
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.name = "operations"
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.full_name = ".Act120BeginRoundReply.operations"
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.number = 2
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.index = 1
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.label = 3
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.has_default_value = false
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.default_value = {}
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.message_type = Activity120Module_pb.ACT120OPERATION_MSG
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.type = 11
Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD.cpp_type = 10
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.name = "Act120BeginRoundReply"
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.full_name = ".Act120BeginRoundReply"
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.nested_types = {}
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.enum_types = {}
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.fields = {
	Activity120Module_pb.ACT120BEGINROUNDREPLYACTIVITYIDFIELD,
	Activity120Module_pb.ACT120BEGINROUNDREPLYOPERATIONSFIELD
}
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.is_extendable = false
Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG.extensions = {}
Activity120Module_pb.ACT120EVENTPARAMFIELD.name = "param"
Activity120Module_pb.ACT120EVENTPARAMFIELD.full_name = ".Act120Event.param"
Activity120Module_pb.ACT120EVENTPARAMFIELD.number = 1
Activity120Module_pb.ACT120EVENTPARAMFIELD.index = 0
Activity120Module_pb.ACT120EVENTPARAMFIELD.label = 1
Activity120Module_pb.ACT120EVENTPARAMFIELD.has_default_value = false
Activity120Module_pb.ACT120EVENTPARAMFIELD.default_value = ""
Activity120Module_pb.ACT120EVENTPARAMFIELD.type = 9
Activity120Module_pb.ACT120EVENTPARAMFIELD.cpp_type = 9
Activity120Module_pb.ACT120EVENT_MSG.name = "Act120Event"
Activity120Module_pb.ACT120EVENT_MSG.full_name = ".Act120Event"
Activity120Module_pb.ACT120EVENT_MSG.nested_types = {}
Activity120Module_pb.ACT120EVENT_MSG.enum_types = {}
Activity120Module_pb.ACT120EVENT_MSG.fields = {
	Activity120Module_pb.ACT120EVENTPARAMFIELD
}
Activity120Module_pb.ACT120EVENT_MSG.is_extendable = false
Activity120Module_pb.ACT120EVENT_MSG.extensions = {}
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.full_name = ".Act120BeginRoundRequest.activityId"
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.name = "operations"
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.full_name = ".Act120BeginRoundRequest.operations"
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.number = 2
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.index = 1
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.label = 3
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.has_default_value = false
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.default_value = {}
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.message_type = Activity120Module_pb.ACT120OPERATION_MSG
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.type = 11
Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD.cpp_type = 10
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.name = "Act120BeginRoundRequest"
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.full_name = ".Act120BeginRoundRequest"
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.nested_types = {}
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.enum_types = {}
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.fields = {
	Activity120Module_pb.ACT120BEGINROUNDREQUESTACTIVITYIDFIELD,
	Activity120Module_pb.ACT120BEGINROUNDREQUESTOPERATIONSFIELD
}
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.is_extendable = false
Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.full_name = ".Act120StepPush.activityId"
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.name = "steps"
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.full_name = ".Act120StepPush.steps"
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.number = 2
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.index = 1
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.label = 3
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.has_default_value = false
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.default_value = {}
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.message_type = Activity120Module_pb.ACT120STEP_MSG
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.type = 11
Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD.cpp_type = 10
Activity120Module_pb.ACT120STEPPUSH_MSG.name = "Act120StepPush"
Activity120Module_pb.ACT120STEPPUSH_MSG.full_name = ".Act120StepPush"
Activity120Module_pb.ACT120STEPPUSH_MSG.nested_types = {}
Activity120Module_pb.ACT120STEPPUSH_MSG.enum_types = {}
Activity120Module_pb.ACT120STEPPUSH_MSG.fields = {
	Activity120Module_pb.ACT120STEPPUSHACTIVITYIDFIELD,
	Activity120Module_pb.ACT120STEPPUSHSTEPSFIELD
}
Activity120Module_pb.ACT120STEPPUSH_MSG.is_extendable = false
Activity120Module_pb.ACT120STEPPUSH_MSG.extensions = {}
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.full_name = ".Act120UseItemReply.activityId"
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.name = "x"
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.full_name = ".Act120UseItemReply.x"
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.number = 2
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.index = 1
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.label = 1
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.has_default_value = false
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.default_value = 0
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.type = 5
Activity120Module_pb.ACT120USEITEMREPLYXFIELD.cpp_type = 1
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.name = "y"
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.full_name = ".Act120UseItemReply.y"
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.number = 3
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.index = 2
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.label = 1
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.has_default_value = false
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.default_value = 0
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.type = 5
Activity120Module_pb.ACT120USEITEMREPLYYFIELD.cpp_type = 1
Activity120Module_pb.ACT120USEITEMREPLY_MSG.name = "Act120UseItemReply"
Activity120Module_pb.ACT120USEITEMREPLY_MSG.full_name = ".Act120UseItemReply"
Activity120Module_pb.ACT120USEITEMREPLY_MSG.nested_types = {}
Activity120Module_pb.ACT120USEITEMREPLY_MSG.enum_types = {}
Activity120Module_pb.ACT120USEITEMREPLY_MSG.fields = {
	Activity120Module_pb.ACT120USEITEMREPLYACTIVITYIDFIELD,
	Activity120Module_pb.ACT120USEITEMREPLYXFIELD,
	Activity120Module_pb.ACT120USEITEMREPLYYFIELD
}
Activity120Module_pb.ACT120USEITEMREPLY_MSG.is_extendable = false
Activity120Module_pb.ACT120USEITEMREPLY_MSG.extensions = {}
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct120InfoReply.activityId"
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.name = "map"
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.full_name = ".GetAct120InfoReply.map"
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.number = 2
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.index = 1
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.label = 1
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.has_default_value = false
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.default_value = nil
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.message_type = Activity120Module_pb.ACT120MAP_MSG
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.type = 11
Activity120Module_pb.GETACT120INFOREPLYMAPFIELD.cpp_type = 10
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.name = "episodes"
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.full_name = ".GetAct120InfoReply.episodes"
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.number = 3
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.index = 2
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.label = 3
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.has_default_value = false
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.default_value = {}
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.message_type = Activity120Module_pb.ACT120EPISODE_MSG
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.type = 11
Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD.cpp_type = 10
Activity120Module_pb.GETACT120INFOREPLY_MSG.name = "GetAct120InfoReply"
Activity120Module_pb.GETACT120INFOREPLY_MSG.full_name = ".GetAct120InfoReply"
Activity120Module_pb.GETACT120INFOREPLY_MSG.nested_types = {}
Activity120Module_pb.GETACT120INFOREPLY_MSG.enum_types = {}
Activity120Module_pb.GETACT120INFOREPLY_MSG.fields = {
	Activity120Module_pb.GETACT120INFOREPLYACTIVITYIDFIELD,
	Activity120Module_pb.GETACT120INFOREPLYMAPFIELD,
	Activity120Module_pb.GETACT120INFOREPLYEPISODESFIELD
}
Activity120Module_pb.GETACT120INFOREPLY_MSG.is_extendable = false
Activity120Module_pb.GETACT120INFOREPLY_MSG.extensions = {}
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct120InfoRequest.activityId"
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.GETACT120INFOREQUEST_MSG.name = "GetAct120InfoRequest"
Activity120Module_pb.GETACT120INFOREQUEST_MSG.full_name = ".GetAct120InfoRequest"
Activity120Module_pb.GETACT120INFOREQUEST_MSG.nested_types = {}
Activity120Module_pb.GETACT120INFOREQUEST_MSG.enum_types = {}
Activity120Module_pb.GETACT120INFOREQUEST_MSG.fields = {
	Activity120Module_pb.GETACT120INFOREQUESTACTIVITYIDFIELD
}
Activity120Module_pb.GETACT120INFOREQUEST_MSG.is_extendable = false
Activity120Module_pb.GETACT120INFOREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120EPISODEIDFIELD.name = "id"
Activity120Module_pb.ACT120EPISODEIDFIELD.full_name = ".Act120Episode.id"
Activity120Module_pb.ACT120EPISODEIDFIELD.number = 1
Activity120Module_pb.ACT120EPISODEIDFIELD.index = 0
Activity120Module_pb.ACT120EPISODEIDFIELD.label = 1
Activity120Module_pb.ACT120EPISODEIDFIELD.has_default_value = false
Activity120Module_pb.ACT120EPISODEIDFIELD.default_value = 0
Activity120Module_pb.ACT120EPISODEIDFIELD.type = 5
Activity120Module_pb.ACT120EPISODEIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120EPISODESTARFIELD.name = "star"
Activity120Module_pb.ACT120EPISODESTARFIELD.full_name = ".Act120Episode.star"
Activity120Module_pb.ACT120EPISODESTARFIELD.number = 2
Activity120Module_pb.ACT120EPISODESTARFIELD.index = 1
Activity120Module_pb.ACT120EPISODESTARFIELD.label = 1
Activity120Module_pb.ACT120EPISODESTARFIELD.has_default_value = false
Activity120Module_pb.ACT120EPISODESTARFIELD.default_value = 0
Activity120Module_pb.ACT120EPISODESTARFIELD.type = 5
Activity120Module_pb.ACT120EPISODESTARFIELD.cpp_type = 1
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.name = "totalCount"
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.full_name = ".Act120Episode.totalCount"
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.number = 3
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.index = 2
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.label = 1
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.has_default_value = false
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.default_value = 0
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.type = 5
Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD.cpp_type = 1
Activity120Module_pb.ACT120EPISODE_MSG.name = "Act120Episode"
Activity120Module_pb.ACT120EPISODE_MSG.full_name = ".Act120Episode"
Activity120Module_pb.ACT120EPISODE_MSG.nested_types = {}
Activity120Module_pb.ACT120EPISODE_MSG.enum_types = {}
Activity120Module_pb.ACT120EPISODE_MSG.fields = {
	Activity120Module_pb.ACT120EPISODEIDFIELD,
	Activity120Module_pb.ACT120EPISODESTARFIELD,
	Activity120Module_pb.ACT120EPISODETOTALCOUNTFIELD
}
Activity120Module_pb.ACT120EPISODE_MSG.is_extendable = false
Activity120Module_pb.ACT120EPISODE_MSG.extensions = {}
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.full_name = ".Act120StartEpisodeRequest.activityId"
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.name = "id"
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.full_name = ".Act120StartEpisodeRequest.id"
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.number = 2
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.index = 1
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.label = 1
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.has_default_value = false
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.default_value = 0
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.type = 5
Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.name = "Act120StartEpisodeRequest"
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.full_name = ".Act120StartEpisodeRequest"
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.nested_types = {}
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.enum_types = {}
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.fields = {
	Activity120Module_pb.ACT120STARTEPISODEREQUESTACTIVITYIDFIELD,
	Activity120Module_pb.ACT120STARTEPISODEREQUESTIDFIELD
}
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.is_extendable = false
Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.full_name = ".Act120EventEndReply.activityId"
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.name = "Act120EventEndReply"
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.full_name = ".Act120EventEndReply"
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.nested_types = {}
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.enum_types = {}
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.fields = {
	Activity120Module_pb.ACT120EVENTENDREPLYACTIVITYIDFIELD
}
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.is_extendable = false
Activity120Module_pb.ACT120EVENTENDREPLY_MSG.extensions = {}
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.name = "activityId"
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.full_name = ".Act120EventEndRequest.activityId"
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.number = 1
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.index = 0
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.label = 1
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.has_default_value = false
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.default_value = 0
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.type = 5
Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.name = "Act120EventEndRequest"
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.full_name = ".Act120EventEndRequest"
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.nested_types = {}
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.enum_types = {}
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.fields = {
	Activity120Module_pb.ACT120EVENTENDREQUESTACTIVITYIDFIELD
}
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.is_extendable = false
Activity120Module_pb.ACT120EVENTENDREQUEST_MSG.extensions = {}
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.name = "id"
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.full_name = ".Act120InteractObject.id"
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.number = 1
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.index = 0
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.label = 1
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.has_default_value = false
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.default_value = 0
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.type = 5
Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.name = "x"
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.full_name = ".Act120InteractObject.x"
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.number = 2
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.index = 1
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.label = 1
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.has_default_value = false
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.default_value = 0
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.type = 5
Activity120Module_pb.ACT120INTERACTOBJECTXFIELD.cpp_type = 1
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.name = "y"
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.full_name = ".Act120InteractObject.y"
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.number = 3
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.index = 2
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.label = 1
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.has_default_value = false
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.default_value = 0
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.type = 5
Activity120Module_pb.ACT120INTERACTOBJECTYFIELD.cpp_type = 1
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.name = "data"
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.full_name = ".Act120InteractObject.data"
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.number = 4
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.index = 3
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.label = 1
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.has_default_value = false
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.default_value = ""
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.type = 9
Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD.cpp_type = 9
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.name = "direction"
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.full_name = ".Act120InteractObject.direction"
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.number = 5
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.index = 4
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.label = 1
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.has_default_value = false
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.default_value = 0
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.type = 5
Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD.cpp_type = 1
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.name = "Act120InteractObject"
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.full_name = ".Act120InteractObject"
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.nested_types = {}
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.enum_types = {}
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.fields = {
	Activity120Module_pb.ACT120INTERACTOBJECTIDFIELD,
	Activity120Module_pb.ACT120INTERACTOBJECTXFIELD,
	Activity120Module_pb.ACT120INTERACTOBJECTYFIELD,
	Activity120Module_pb.ACT120INTERACTOBJECTDATAFIELD,
	Activity120Module_pb.ACT120INTERACTOBJECTDIRECTIONFIELD
}
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.is_extendable = false
Activity120Module_pb.ACT120INTERACTOBJECT_MSG.extensions = {}
Activity120Module_pb.ACT120POINTXFIELD.name = "x"
Activity120Module_pb.ACT120POINTXFIELD.full_name = ".Act120Point.x"
Activity120Module_pb.ACT120POINTXFIELD.number = 1
Activity120Module_pb.ACT120POINTXFIELD.index = 0
Activity120Module_pb.ACT120POINTXFIELD.label = 1
Activity120Module_pb.ACT120POINTXFIELD.has_default_value = false
Activity120Module_pb.ACT120POINTXFIELD.default_value = 0
Activity120Module_pb.ACT120POINTXFIELD.type = 5
Activity120Module_pb.ACT120POINTXFIELD.cpp_type = 1
Activity120Module_pb.ACT120POINTYFIELD.name = "y"
Activity120Module_pb.ACT120POINTYFIELD.full_name = ".Act120Point.y"
Activity120Module_pb.ACT120POINTYFIELD.number = 2
Activity120Module_pb.ACT120POINTYFIELD.index = 1
Activity120Module_pb.ACT120POINTYFIELD.label = 1
Activity120Module_pb.ACT120POINTYFIELD.has_default_value = false
Activity120Module_pb.ACT120POINTYFIELD.default_value = 0
Activity120Module_pb.ACT120POINTYFIELD.type = 5
Activity120Module_pb.ACT120POINTYFIELD.cpp_type = 1
Activity120Module_pb.ACT120POINT_MSG.name = "Act120Point"
Activity120Module_pb.ACT120POINT_MSG.full_name = ".Act120Point"
Activity120Module_pb.ACT120POINT_MSG.nested_types = {}
Activity120Module_pb.ACT120POINT_MSG.enum_types = {}
Activity120Module_pb.ACT120POINT_MSG.fields = {
	Activity120Module_pb.ACT120POINTXFIELD,
	Activity120Module_pb.ACT120POINTYFIELD
}
Activity120Module_pb.ACT120POINT_MSG.is_extendable = false
Activity120Module_pb.ACT120POINT_MSG.extensions = {}
Activity120Module_pb.ACT120OPERATIONIDFIELD.name = "id"
Activity120Module_pb.ACT120OPERATIONIDFIELD.full_name = ".Act120Operation.id"
Activity120Module_pb.ACT120OPERATIONIDFIELD.number = 1
Activity120Module_pb.ACT120OPERATIONIDFIELD.index = 0
Activity120Module_pb.ACT120OPERATIONIDFIELD.label = 1
Activity120Module_pb.ACT120OPERATIONIDFIELD.has_default_value = false
Activity120Module_pb.ACT120OPERATIONIDFIELD.default_value = 0
Activity120Module_pb.ACT120OPERATIONIDFIELD.type = 5
Activity120Module_pb.ACT120OPERATIONIDFIELD.cpp_type = 1
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.name = "moveDirection"
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.full_name = ".Act120Operation.moveDirection"
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.number = 2
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.index = 1
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.label = 1
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.has_default_value = false
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.default_value = 0
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.type = 5
Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD.cpp_type = 1
Activity120Module_pb.ACT120OPERATION_MSG.name = "Act120Operation"
Activity120Module_pb.ACT120OPERATION_MSG.full_name = ".Act120Operation"
Activity120Module_pb.ACT120OPERATION_MSG.nested_types = {}
Activity120Module_pb.ACT120OPERATION_MSG.enum_types = {}
Activity120Module_pb.ACT120OPERATION_MSG.fields = {
	Activity120Module_pb.ACT120OPERATIONIDFIELD,
	Activity120Module_pb.ACT120OPERATIONMOVEDIRECTIONFIELD
}
Activity120Module_pb.ACT120OPERATION_MSG.is_extendable = false
Activity120Module_pb.ACT120OPERATION_MSG.extensions = {}
Activity120Module_pb.ACT120STEPPARAMFIELD.name = "param"
Activity120Module_pb.ACT120STEPPARAMFIELD.full_name = ".Act120Step.param"
Activity120Module_pb.ACT120STEPPARAMFIELD.number = 1
Activity120Module_pb.ACT120STEPPARAMFIELD.index = 0
Activity120Module_pb.ACT120STEPPARAMFIELD.label = 1
Activity120Module_pb.ACT120STEPPARAMFIELD.has_default_value = false
Activity120Module_pb.ACT120STEPPARAMFIELD.default_value = ""
Activity120Module_pb.ACT120STEPPARAMFIELD.type = 9
Activity120Module_pb.ACT120STEPPARAMFIELD.cpp_type = 9
Activity120Module_pb.ACT120STEP_MSG.name = "Act120Step"
Activity120Module_pb.ACT120STEP_MSG.full_name = ".Act120Step"
Activity120Module_pb.ACT120STEP_MSG.nested_types = {}
Activity120Module_pb.ACT120STEP_MSG.enum_types = {}
Activity120Module_pb.ACT120STEP_MSG.fields = {
	Activity120Module_pb.ACT120STEPPARAMFIELD
}
Activity120Module_pb.ACT120STEP_MSG.is_extendable = false
Activity120Module_pb.ACT120STEP_MSG.extensions = {}
Activity120Module_pb.Act120AbortReply = protobuf.Message(Activity120Module_pb.ACT120ABORTREPLY_MSG)
Activity120Module_pb.Act120AbortRequest = protobuf.Message(Activity120Module_pb.ACT120ABORTREQUEST_MSG)
Activity120Module_pb.Act120BeginRoundReply = protobuf.Message(Activity120Module_pb.ACT120BEGINROUNDREPLY_MSG)
Activity120Module_pb.Act120BeginRoundRequest = protobuf.Message(Activity120Module_pb.ACT120BEGINROUNDREQUEST_MSG)
Activity120Module_pb.Act120CheckPointReply = protobuf.Message(Activity120Module_pb.ACT120CHECKPOINTREPLY_MSG)
Activity120Module_pb.Act120CheckPointRequest = protobuf.Message(Activity120Module_pb.ACT120CHECKPOINTREQUEST_MSG)
Activity120Module_pb.Act120Episode = protobuf.Message(Activity120Module_pb.ACT120EPISODE_MSG)
Activity120Module_pb.Act120Event = protobuf.Message(Activity120Module_pb.ACT120EVENT_MSG)
Activity120Module_pb.Act120EventEndReply = protobuf.Message(Activity120Module_pb.ACT120EVENTENDREPLY_MSG)
Activity120Module_pb.Act120EventEndRequest = protobuf.Message(Activity120Module_pb.ACT120EVENTENDREQUEST_MSG)
Activity120Module_pb.Act120InteractObject = protobuf.Message(Activity120Module_pb.ACT120INTERACTOBJECT_MSG)
Activity120Module_pb.Act120Map = protobuf.Message(Activity120Module_pb.ACT120MAP_MSG)
Activity120Module_pb.Act120Operation = protobuf.Message(Activity120Module_pb.ACT120OPERATION_MSG)
Activity120Module_pb.Act120Point = protobuf.Message(Activity120Module_pb.ACT120POINT_MSG)
Activity120Module_pb.Act120StartEpisodeReply = protobuf.Message(Activity120Module_pb.ACT120STARTEPISODEREPLY_MSG)
Activity120Module_pb.Act120StartEpisodeRequest = protobuf.Message(Activity120Module_pb.ACT120STARTEPISODEREQUEST_MSG)
Activity120Module_pb.Act120Step = protobuf.Message(Activity120Module_pb.ACT120STEP_MSG)
Activity120Module_pb.Act120StepPush = protobuf.Message(Activity120Module_pb.ACT120STEPPUSH_MSG)
Activity120Module_pb.Act120UseItemReply = protobuf.Message(Activity120Module_pb.ACT120USEITEMREPLY_MSG)
Activity120Module_pb.Act120UseItemRequest = protobuf.Message(Activity120Module_pb.ACT120USEITEMREQUEST_MSG)
Activity120Module_pb.GetAct120InfoReply = protobuf.Message(Activity120Module_pb.GETACT120INFOREPLY_MSG)
Activity120Module_pb.GetAct120InfoRequest = protobuf.Message(Activity120Module_pb.GETACT120INFOREQUEST_MSG)

return Activity120Module_pb
