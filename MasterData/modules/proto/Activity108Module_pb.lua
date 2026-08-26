-- chunkname: @modules/proto/Activity108Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity108Module_pb", package.seeall)

local Activity108Module_pb = {}

Activity108Module_pb.FIGHTDEF_PB = require("modules.proto.FightDef_pb")
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG = protobuf.Descriptor()
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFO_MSG = protobuf.Descriptor()
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFOMAPIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFOISFINISHFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFOEVENTSFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEINFOCONFIRMFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEEVENT_MSG = protobuf.Descriptor()
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEEVENTISFINISHFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEEVENTOPTIONFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEEVENTINDEXFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG = protobuf.Descriptor()
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEUPDATEPUSH_MSG = protobuf.Descriptor()
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEHISTORY_MSG = protobuf.Descriptor()
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODEHISTORYINDEXFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108INFOSREPLY_MSG = protobuf.Descriptor()
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG = protobuf.Descriptor()
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.RESETMAPREQUEST_MSG = protobuf.Descriptor()
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG = protobuf.Descriptor()
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108INFOSREQUEST_MSG = protobuf.Descriptor()
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.RESETMAPREPLY_MSG = protobuf.Descriptor()
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.RESETMAPREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EVENTHISTORY_MSG = protobuf.Descriptor()
Activity108Module_pb.EVENTHISTORYINDEXFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EVENTHISTORYHISTORYFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108BONUSREQUEST_MSG = protobuf.Descriptor()
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108BONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.INFOUPDATEPUSH_MSG = protobuf.Descriptor()
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFO_MSG = protobuf.Descriptor()
Activity108Module_pb.MAPINFOMAPIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOSCOREFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOISFINISHFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108BONUSREPLY_MSG = protobuf.Descriptor()
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.GET108BONUSREPLYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODECONFIRMREPLY_MSG = protobuf.Descriptor()
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG = protobuf.Descriptor()
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD = protobuf.FieldDescriptor()
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.full_name = ".EnterFightEventRequest.activityId"
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.number = 1
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.index = 0
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.label = 1
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.type = 5
Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.name = "eventId"
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.full_name = ".EnterFightEventRequest.eventId"
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.number = 2
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.index = 1
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.label = 1
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.has_default_value = false
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.default_value = 0
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.type = 5
Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD.cpp_type = 1
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.name = "EnterFightEventRequest"
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.full_name = ".EnterFightEventRequest"
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.nested_types = {}
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.enum_types = {}
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.fields = {
	Activity108Module_pb.ENTERFIGHTEVENTREQUESTACTIVITYIDFIELD,
	Activity108Module_pb.ENTERFIGHTEVENTREQUESTEVENTIDFIELD
}
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.is_extendable = false
Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG.extensions = {}
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.name = "episodeId"
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.full_name = ".EpisodeInfo.episodeId"
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.number = 1
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.index = 0
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.label = 1
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.default_value = 0
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.type = 5
Activity108Module_pb.EPISODEINFOEPISODEIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODEINFOMAPIDFIELD.name = "mapId"
Activity108Module_pb.EPISODEINFOMAPIDFIELD.full_name = ".EpisodeInfo.mapId"
Activity108Module_pb.EPISODEINFOMAPIDFIELD.number = 2
Activity108Module_pb.EPISODEINFOMAPIDFIELD.index = 1
Activity108Module_pb.EPISODEINFOMAPIDFIELD.label = 1
Activity108Module_pb.EPISODEINFOMAPIDFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOMAPIDFIELD.default_value = 0
Activity108Module_pb.EPISODEINFOMAPIDFIELD.type = 5
Activity108Module_pb.EPISODEINFOMAPIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODEINFOISFINISHFIELD.name = "isFinish"
Activity108Module_pb.EPISODEINFOISFINISHFIELD.full_name = ".EpisodeInfo.isFinish"
Activity108Module_pb.EPISODEINFOISFINISHFIELD.number = 3
Activity108Module_pb.EPISODEINFOISFINISHFIELD.index = 2
Activity108Module_pb.EPISODEINFOISFINISHFIELD.label = 1
Activity108Module_pb.EPISODEINFOISFINISHFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOISFINISHFIELD.default_value = false
Activity108Module_pb.EPISODEINFOISFINISHFIELD.type = 8
Activity108Module_pb.EPISODEINFOISFINISHFIELD.cpp_type = 7
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.name = "leftActPoint"
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.full_name = ".EpisodeInfo.leftActPoint"
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.number = 4
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.index = 3
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.label = 1
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.default_value = 0
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.type = 5
Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD.cpp_type = 1
Activity108Module_pb.EPISODEINFOEVENTSFIELD.name = "events"
Activity108Module_pb.EPISODEINFOEVENTSFIELD.full_name = ".EpisodeInfo.events"
Activity108Module_pb.EPISODEINFOEVENTSFIELD.number = 5
Activity108Module_pb.EPISODEINFOEVENTSFIELD.index = 4
Activity108Module_pb.EPISODEINFOEVENTSFIELD.label = 3
Activity108Module_pb.EPISODEINFOEVENTSFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOEVENTSFIELD.default_value = {}
Activity108Module_pb.EPISODEINFOEVENTSFIELD.message_type = Activity108Module_pb.EPISODEEVENT_MSG
Activity108Module_pb.EPISODEINFOEVENTSFIELD.type = 11
Activity108Module_pb.EPISODEINFOEVENTSFIELD.cpp_type = 10
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.name = "historylist"
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.full_name = ".EpisodeInfo.historylist"
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.number = 6
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.index = 5
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.label = 3
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.default_value = {}
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.message_type = Activity108Module_pb.EPISODEHISTORY_MSG
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.type = 11
Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD.cpp_type = 10
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.name = "confirm"
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.full_name = ".EpisodeInfo.confirm"
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.number = 7
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.index = 6
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.label = 1
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.has_default_value = false
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.default_value = false
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.type = 8
Activity108Module_pb.EPISODEINFOCONFIRMFIELD.cpp_type = 7
Activity108Module_pb.EPISODEINFO_MSG.name = "EpisodeInfo"
Activity108Module_pb.EPISODEINFO_MSG.full_name = ".EpisodeInfo"
Activity108Module_pb.EPISODEINFO_MSG.nested_types = {}
Activity108Module_pb.EPISODEINFO_MSG.enum_types = {}
Activity108Module_pb.EPISODEINFO_MSG.fields = {
	Activity108Module_pb.EPISODEINFOEPISODEIDFIELD,
	Activity108Module_pb.EPISODEINFOMAPIDFIELD,
	Activity108Module_pb.EPISODEINFOISFINISHFIELD,
	Activity108Module_pb.EPISODEINFOLEFTACTPOINTFIELD,
	Activity108Module_pb.EPISODEINFOEVENTSFIELD,
	Activity108Module_pb.EPISODEINFOHISTORYLISTFIELD,
	Activity108Module_pb.EPISODEINFOCONFIRMFIELD
}
Activity108Module_pb.EPISODEINFO_MSG.is_extendable = false
Activity108Module_pb.EPISODEINFO_MSG.extensions = {}
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.name = "eventId"
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.full_name = ".EpisodeEvent.eventId"
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.number = 1
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.index = 0
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.label = 1
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.has_default_value = false
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.default_value = 0
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.type = 5
Activity108Module_pb.EPISODEEVENTEVENTIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.name = "isFinish"
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.full_name = ".EpisodeEvent.isFinish"
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.number = 2
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.index = 1
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.label = 1
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.has_default_value = false
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.default_value = false
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.type = 8
Activity108Module_pb.EPISODEEVENTISFINISHFIELD.cpp_type = 7
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.name = "historylist"
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.full_name = ".EpisodeEvent.historylist"
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.number = 3
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.index = 2
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.label = 3
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.has_default_value = false
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.default_value = {}
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.message_type = Activity108Module_pb.EVENTHISTORY_MSG
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.type = 11
Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD.cpp_type = 10
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.name = "option"
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.full_name = ".EpisodeEvent.option"
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.number = 4
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.index = 3
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.label = 3
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.has_default_value = false
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.default_value = {}
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.type = 5
Activity108Module_pb.EPISODEEVENTOPTIONFIELD.cpp_type = 1
Activity108Module_pb.EPISODEEVENTINDEXFIELD.name = "index"
Activity108Module_pb.EPISODEEVENTINDEXFIELD.full_name = ".EpisodeEvent.index"
Activity108Module_pb.EPISODEEVENTINDEXFIELD.number = 5
Activity108Module_pb.EPISODEEVENTINDEXFIELD.index = 4
Activity108Module_pb.EPISODEEVENTINDEXFIELD.label = 1
Activity108Module_pb.EPISODEEVENTINDEXFIELD.has_default_value = false
Activity108Module_pb.EPISODEEVENTINDEXFIELD.default_value = 0
Activity108Module_pb.EPISODEEVENTINDEXFIELD.type = 5
Activity108Module_pb.EPISODEEVENTINDEXFIELD.cpp_type = 1
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.name = "historySelect"
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.full_name = ".EpisodeEvent.historySelect"
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.number = 6
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.index = 5
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.label = 3
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.has_default_value = false
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.default_value = {}
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.type = 5
Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD.cpp_type = 1
Activity108Module_pb.EPISODEEVENT_MSG.name = "EpisodeEvent"
Activity108Module_pb.EPISODEEVENT_MSG.full_name = ".EpisodeEvent"
Activity108Module_pb.EPISODEEVENT_MSG.nested_types = {}
Activity108Module_pb.EPISODEEVENT_MSG.enum_types = {}
Activity108Module_pb.EPISODEEVENT_MSG.fields = {
	Activity108Module_pb.EPISODEEVENTEVENTIDFIELD,
	Activity108Module_pb.EPISODEEVENTISFINISHFIELD,
	Activity108Module_pb.EPISODEEVENTHISTORYLISTFIELD,
	Activity108Module_pb.EPISODEEVENTOPTIONFIELD,
	Activity108Module_pb.EPISODEEVENTINDEXFIELD,
	Activity108Module_pb.EPISODEEVENTHISTORYSELECTFIELD
}
Activity108Module_pb.EPISODEEVENT_MSG.is_extendable = false
Activity108Module_pb.EPISODEEVENT_MSG.extensions = {}
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.full_name = ".EnterFightEventReply.activityId"
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.number = 1
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.index = 0
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.label = 1
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.type = 5
Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.name = "eventId"
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.full_name = ".EnterFightEventReply.eventId"
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.number = 2
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.index = 1
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.label = 1
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.has_default_value = false
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.default_value = 0
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.type = 5
Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD.cpp_type = 1
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.name = "EnterFightEventReply"
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.full_name = ".EnterFightEventReply"
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.nested_types = {}
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.enum_types = {}
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.fields = {
	Activity108Module_pb.ENTERFIGHTEVENTREPLYACTIVITYIDFIELD,
	Activity108Module_pb.ENTERFIGHTEVENTREPLYEVENTIDFIELD
}
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.is_extendable = false
Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG.extensions = {}
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.full_name = ".EpisodeUpdatePush.activityId"
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.number = 1
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.index = 0
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.label = 1
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.type = 5
Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.name = "info"
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.full_name = ".EpisodeUpdatePush.info"
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.number = 2
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.index = 1
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.label = 1
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.has_default_value = false
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.default_value = nil
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.message_type = Activity108Module_pb.EPISODEINFO_MSG
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.type = 11
Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD.cpp_type = 10
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.name = "EpisodeUpdatePush"
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.full_name = ".EpisodeUpdatePush"
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.nested_types = {}
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.enum_types = {}
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.fields = {
	Activity108Module_pb.EPISODEUPDATEPUSHACTIVITYIDFIELD,
	Activity108Module_pb.EPISODEUPDATEPUSHINFOFIELD
}
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.is_extendable = false
Activity108Module_pb.EPISODEUPDATEPUSH_MSG.extensions = {}
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.name = "eventId"
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.full_name = ".EpisodeHistory.eventId"
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.number = 1
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.index = 0
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.label = 1
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.has_default_value = false
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.default_value = 0
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.type = 5
Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.name = "index"
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.full_name = ".EpisodeHistory.index"
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.number = 2
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.index = 1
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.label = 1
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.has_default_value = false
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.default_value = 0
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.type = 5
Activity108Module_pb.EPISODEHISTORYINDEXFIELD.cpp_type = 1
Activity108Module_pb.EPISODEHISTORY_MSG.name = "EpisodeHistory"
Activity108Module_pb.EPISODEHISTORY_MSG.full_name = ".EpisodeHistory"
Activity108Module_pb.EPISODEHISTORY_MSG.nested_types = {}
Activity108Module_pb.EPISODEHISTORY_MSG.enum_types = {}
Activity108Module_pb.EPISODEHISTORY_MSG.fields = {
	Activity108Module_pb.EPISODEHISTORYEVENTIDFIELD,
	Activity108Module_pb.EPISODEHISTORYINDEXFIELD
}
Activity108Module_pb.EPISODEHISTORY_MSG.is_extendable = false
Activity108Module_pb.EPISODEHISTORY_MSG.extensions = {}
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.full_name = ".Get108InfosReply.activityId"
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.number = 1
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.index = 0
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.label = 1
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.type = 5
Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.name = "infos"
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.full_name = ".Get108InfosReply.infos"
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.number = 2
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.index = 1
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.label = 3
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.has_default_value = false
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.default_value = {}
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.message_type = Activity108Module_pb.MAPINFO_MSG
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.type = 11
Activity108Module_pb.GET108INFOSREPLYINFOSFIELD.cpp_type = 10
Activity108Module_pb.GET108INFOSREPLY_MSG.name = "Get108InfosReply"
Activity108Module_pb.GET108INFOSREPLY_MSG.full_name = ".Get108InfosReply"
Activity108Module_pb.GET108INFOSREPLY_MSG.nested_types = {}
Activity108Module_pb.GET108INFOSREPLY_MSG.enum_types = {}
Activity108Module_pb.GET108INFOSREPLY_MSG.fields = {
	Activity108Module_pb.GET108INFOSREPLYACTIVITYIDFIELD,
	Activity108Module_pb.GET108INFOSREPLYINFOSFIELD
}
Activity108Module_pb.GET108INFOSREPLY_MSG.is_extendable = false
Activity108Module_pb.GET108INFOSREPLY_MSG.extensions = {}
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.full_name = ".DialogEventSelectRequest.activityId"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.number = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.index = 0
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.label = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.type = 5
Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.name = "eventId"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.full_name = ".DialogEventSelectRequest.eventId"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.number = 2
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.index = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.label = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.default_value = 0
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.type = 5
Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD.cpp_type = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.name = "historylist"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.full_name = ".DialogEventSelectRequest.historylist"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.number = 3
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.index = 2
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.label = 3
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.default_value = {}
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.type = 9
Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD.cpp_type = 9
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.name = "option"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.full_name = ".DialogEventSelectRequest.option"
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.number = 4
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.index = 3
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.label = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.default_value = 0
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.type = 5
Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD.cpp_type = 1
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.name = "DialogEventSelectRequest"
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.full_name = ".DialogEventSelectRequest"
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.nested_types = {}
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.enum_types = {}
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.fields = {
	Activity108Module_pb.DIALOGEVENTSELECTREQUESTACTIVITYIDFIELD,
	Activity108Module_pb.DIALOGEVENTSELECTREQUESTEVENTIDFIELD,
	Activity108Module_pb.DIALOGEVENTSELECTREQUESTHISTORYLISTFIELD,
	Activity108Module_pb.DIALOGEVENTSELECTREQUESTOPTIONFIELD
}
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.is_extendable = false
Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG.extensions = {}
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.full_name = ".ResetMapRequest.activityId"
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.number = 1
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.index = 0
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.label = 1
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.type = 5
Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.name = "mapId"
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.full_name = ".ResetMapRequest.mapId"
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.number = 2
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.index = 1
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.label = 1
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.has_default_value = false
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.default_value = 0
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.type = 5
Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD.cpp_type = 1
Activity108Module_pb.RESETMAPREQUEST_MSG.name = "ResetMapRequest"
Activity108Module_pb.RESETMAPREQUEST_MSG.full_name = ".ResetMapRequest"
Activity108Module_pb.RESETMAPREQUEST_MSG.nested_types = {}
Activity108Module_pb.RESETMAPREQUEST_MSG.enum_types = {}
Activity108Module_pb.RESETMAPREQUEST_MSG.fields = {
	Activity108Module_pb.RESETMAPREQUESTACTIVITYIDFIELD,
	Activity108Module_pb.RESETMAPREQUESTMAPIDFIELD
}
Activity108Module_pb.RESETMAPREQUEST_MSG.is_extendable = false
Activity108Module_pb.RESETMAPREQUEST_MSG.extensions = {}
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.full_name = ".DialogEventSelectReply.activityId"
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.number = 1
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.index = 0
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.label = 1
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.type = 5
Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.name = "info"
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.full_name = ".DialogEventSelectReply.info"
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.number = 2
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.index = 1
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.label = 1
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.default_value = nil
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.message_type = Activity108Module_pb.EPISODEINFO_MSG
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.type = 11
Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD.cpp_type = 10
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.name = "mapInfo"
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.full_name = ".DialogEventSelectReply.mapInfo"
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.number = 3
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.index = 2
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.label = 1
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.has_default_value = false
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.default_value = nil
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.message_type = Activity108Module_pb.MAPINFO_MSG
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.type = 11
Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD.cpp_type = 10
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.name = "DialogEventSelectReply"
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.full_name = ".DialogEventSelectReply"
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.nested_types = {}
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.enum_types = {}
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.fields = {
	Activity108Module_pb.DIALOGEVENTSELECTREPLYACTIVITYIDFIELD,
	Activity108Module_pb.DIALOGEVENTSELECTREPLYINFOFIELD,
	Activity108Module_pb.DIALOGEVENTSELECTREPLYMAPINFOFIELD
}
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.is_extendable = false
Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG.extensions = {}
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get108InfosRequest.activityId"
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.GET108INFOSREQUEST_MSG.name = "Get108InfosRequest"
Activity108Module_pb.GET108INFOSREQUEST_MSG.full_name = ".Get108InfosRequest"
Activity108Module_pb.GET108INFOSREQUEST_MSG.nested_types = {}
Activity108Module_pb.GET108INFOSREQUEST_MSG.enum_types = {}
Activity108Module_pb.GET108INFOSREQUEST_MSG.fields = {
	Activity108Module_pb.GET108INFOSREQUESTACTIVITYIDFIELD
}
Activity108Module_pb.GET108INFOSREQUEST_MSG.is_extendable = false
Activity108Module_pb.GET108INFOSREQUEST_MSG.extensions = {}
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.full_name = ".ResetMapReply.activityId"
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.number = 1
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.index = 0
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.label = 1
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.type = 5
Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.RESETMAPREPLYINFOFIELD.name = "info"
Activity108Module_pb.RESETMAPREPLYINFOFIELD.full_name = ".ResetMapReply.info"
Activity108Module_pb.RESETMAPREPLYINFOFIELD.number = 2
Activity108Module_pb.RESETMAPREPLYINFOFIELD.index = 1
Activity108Module_pb.RESETMAPREPLYINFOFIELD.label = 1
Activity108Module_pb.RESETMAPREPLYINFOFIELD.has_default_value = false
Activity108Module_pb.RESETMAPREPLYINFOFIELD.default_value = nil
Activity108Module_pb.RESETMAPREPLYINFOFIELD.message_type = Activity108Module_pb.MAPINFO_MSG
Activity108Module_pb.RESETMAPREPLYINFOFIELD.type = 11
Activity108Module_pb.RESETMAPREPLYINFOFIELD.cpp_type = 10
Activity108Module_pb.RESETMAPREPLY_MSG.name = "ResetMapReply"
Activity108Module_pb.RESETMAPREPLY_MSG.full_name = ".ResetMapReply"
Activity108Module_pb.RESETMAPREPLY_MSG.nested_types = {}
Activity108Module_pb.RESETMAPREPLY_MSG.enum_types = {}
Activity108Module_pb.RESETMAPREPLY_MSG.fields = {
	Activity108Module_pb.RESETMAPREPLYACTIVITYIDFIELD,
	Activity108Module_pb.RESETMAPREPLYINFOFIELD
}
Activity108Module_pb.RESETMAPREPLY_MSG.is_extendable = false
Activity108Module_pb.RESETMAPREPLY_MSG.extensions = {}
Activity108Module_pb.EVENTHISTORYINDEXFIELD.name = "index"
Activity108Module_pb.EVENTHISTORYINDEXFIELD.full_name = ".EventHistory.index"
Activity108Module_pb.EVENTHISTORYINDEXFIELD.number = 1
Activity108Module_pb.EVENTHISTORYINDEXFIELD.index = 0
Activity108Module_pb.EVENTHISTORYINDEXFIELD.label = 1
Activity108Module_pb.EVENTHISTORYINDEXFIELD.has_default_value = false
Activity108Module_pb.EVENTHISTORYINDEXFIELD.default_value = 0
Activity108Module_pb.EVENTHISTORYINDEXFIELD.type = 5
Activity108Module_pb.EVENTHISTORYINDEXFIELD.cpp_type = 1
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.name = "history"
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.full_name = ".EventHistory.history"
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.number = 2
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.index = 1
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.label = 3
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.has_default_value = false
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.default_value = {}
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.type = 9
Activity108Module_pb.EVENTHISTORYHISTORYFIELD.cpp_type = 9
Activity108Module_pb.EVENTHISTORY_MSG.name = "EventHistory"
Activity108Module_pb.EVENTHISTORY_MSG.full_name = ".EventHistory"
Activity108Module_pb.EVENTHISTORY_MSG.nested_types = {}
Activity108Module_pb.EVENTHISTORY_MSG.enum_types = {}
Activity108Module_pb.EVENTHISTORY_MSG.fields = {
	Activity108Module_pb.EVENTHISTORYINDEXFIELD,
	Activity108Module_pb.EVENTHISTORYHISTORYFIELD
}
Activity108Module_pb.EVENTHISTORY_MSG.is_extendable = false
Activity108Module_pb.EVENTHISTORY_MSG.extensions = {}
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.full_name = ".Get108BonusRequest.activityId"
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.name = "id"
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.full_name = ".Get108BonusRequest.id"
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.number = 2
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.index = 1
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.label = 1
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.has_default_value = false
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.default_value = 0
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.type = 5
Activity108Module_pb.GET108BONUSREQUESTIDFIELD.cpp_type = 1
Activity108Module_pb.GET108BONUSREQUEST_MSG.name = "Get108BonusRequest"
Activity108Module_pb.GET108BONUSREQUEST_MSG.full_name = ".Get108BonusRequest"
Activity108Module_pb.GET108BONUSREQUEST_MSG.nested_types = {}
Activity108Module_pb.GET108BONUSREQUEST_MSG.enum_types = {}
Activity108Module_pb.GET108BONUSREQUEST_MSG.fields = {
	Activity108Module_pb.GET108BONUSREQUESTACTIVITYIDFIELD,
	Activity108Module_pb.GET108BONUSREQUESTIDFIELD
}
Activity108Module_pb.GET108BONUSREQUEST_MSG.is_extendable = false
Activity108Module_pb.GET108BONUSREQUEST_MSG.extensions = {}
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.full_name = ".InfoUpdatePush.activityId"
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.number = 1
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.index = 0
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.label = 1
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.type = 5
Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.name = "infos"
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.full_name = ".InfoUpdatePush.infos"
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.number = 2
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.index = 1
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.label = 3
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.has_default_value = false
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.default_value = {}
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.message_type = Activity108Module_pb.MAPINFO_MSG
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.type = 11
Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD.cpp_type = 10
Activity108Module_pb.INFOUPDATEPUSH_MSG.name = "InfoUpdatePush"
Activity108Module_pb.INFOUPDATEPUSH_MSG.full_name = ".InfoUpdatePush"
Activity108Module_pb.INFOUPDATEPUSH_MSG.nested_types = {}
Activity108Module_pb.INFOUPDATEPUSH_MSG.enum_types = {}
Activity108Module_pb.INFOUPDATEPUSH_MSG.fields = {
	Activity108Module_pb.INFOUPDATEPUSHACTIVITYIDFIELD,
	Activity108Module_pb.INFOUPDATEPUSHINFOSFIELD
}
Activity108Module_pb.INFOUPDATEPUSH_MSG.is_extendable = false
Activity108Module_pb.INFOUPDATEPUSH_MSG.extensions = {}
Activity108Module_pb.MAPINFOMAPIDFIELD.name = "mapId"
Activity108Module_pb.MAPINFOMAPIDFIELD.full_name = ".MapInfo.mapId"
Activity108Module_pb.MAPINFOMAPIDFIELD.number = 1
Activity108Module_pb.MAPINFOMAPIDFIELD.index = 0
Activity108Module_pb.MAPINFOMAPIDFIELD.label = 1
Activity108Module_pb.MAPINFOMAPIDFIELD.has_default_value = false
Activity108Module_pb.MAPINFOMAPIDFIELD.default_value = 0
Activity108Module_pb.MAPINFOMAPIDFIELD.type = 5
Activity108Module_pb.MAPINFOMAPIDFIELD.cpp_type = 1
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.name = "episodeInfos"
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.full_name = ".MapInfo.episodeInfos"
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.number = 2
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.index = 1
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.label = 3
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.has_default_value = false
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.default_value = {}
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.message_type = Activity108Module_pb.EPISODEINFO_MSG
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.type = 11
Activity108Module_pb.MAPINFOEPISODEINFOSFIELD.cpp_type = 10
Activity108Module_pb.MAPINFOSCOREFIELD.name = "score"
Activity108Module_pb.MAPINFOSCOREFIELD.full_name = ".MapInfo.score"
Activity108Module_pb.MAPINFOSCOREFIELD.number = 3
Activity108Module_pb.MAPINFOSCOREFIELD.index = 2
Activity108Module_pb.MAPINFOSCOREFIELD.label = 1
Activity108Module_pb.MAPINFOSCOREFIELD.has_default_value = false
Activity108Module_pb.MAPINFOSCOREFIELD.default_value = 0
Activity108Module_pb.MAPINFOSCOREFIELD.type = 5
Activity108Module_pb.MAPINFOSCOREFIELD.cpp_type = 1
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.name = "highestScore"
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.full_name = ".MapInfo.highestScore"
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.number = 4
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.index = 3
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.label = 1
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.has_default_value = false
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.default_value = 0
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.type = 5
Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD.cpp_type = 1
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.name = "getRewardIds"
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.full_name = ".MapInfo.getRewardIds"
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.number = 5
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.index = 4
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.label = 3
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.has_default_value = false
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.default_value = {}
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.type = 5
Activity108Module_pb.MAPINFOGETREWARDIDSFIELD.cpp_type = 1
Activity108Module_pb.MAPINFOISFINISHFIELD.name = "isFinish"
Activity108Module_pb.MAPINFOISFINISHFIELD.full_name = ".MapInfo.isFinish"
Activity108Module_pb.MAPINFOISFINISHFIELD.number = 6
Activity108Module_pb.MAPINFOISFINISHFIELD.index = 5
Activity108Module_pb.MAPINFOISFINISHFIELD.label = 1
Activity108Module_pb.MAPINFOISFINISHFIELD.has_default_value = false
Activity108Module_pb.MAPINFOISFINISHFIELD.default_value = false
Activity108Module_pb.MAPINFOISFINISHFIELD.type = 8
Activity108Module_pb.MAPINFOISFINISHFIELD.cpp_type = 7
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.name = "excludeRules"
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.full_name = ".MapInfo.excludeRules"
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.number = 7
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.index = 6
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.label = 3
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.has_default_value = false
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.default_value = {}
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.type = 5
Activity108Module_pb.MAPINFOEXCLUDERULESFIELD.cpp_type = 1
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.name = "totalCount"
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.full_name = ".MapInfo.totalCount"
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.number = 8
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.index = 7
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.label = 1
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.has_default_value = false
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.default_value = 0
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.type = 5
Activity108Module_pb.MAPINFOTOTALCOUNTFIELD.cpp_type = 1
Activity108Module_pb.MAPINFO_MSG.name = "MapInfo"
Activity108Module_pb.MAPINFO_MSG.full_name = ".MapInfo"
Activity108Module_pb.MAPINFO_MSG.nested_types = {}
Activity108Module_pb.MAPINFO_MSG.enum_types = {}
Activity108Module_pb.MAPINFO_MSG.fields = {
	Activity108Module_pb.MAPINFOMAPIDFIELD,
	Activity108Module_pb.MAPINFOEPISODEINFOSFIELD,
	Activity108Module_pb.MAPINFOSCOREFIELD,
	Activity108Module_pb.MAPINFOHIGHESTSCOREFIELD,
	Activity108Module_pb.MAPINFOGETREWARDIDSFIELD,
	Activity108Module_pb.MAPINFOISFINISHFIELD,
	Activity108Module_pb.MAPINFOEXCLUDERULESFIELD,
	Activity108Module_pb.MAPINFOTOTALCOUNTFIELD
}
Activity108Module_pb.MAPINFO_MSG.is_extendable = false
Activity108Module_pb.MAPINFO_MSG.extensions = {}
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.full_name = ".Get108BonusReply.activityId"
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.number = 1
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.index = 0
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.label = 1
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.type = 5
Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.GET108BONUSREPLYIDFIELD.name = "id"
Activity108Module_pb.GET108BONUSREPLYIDFIELD.full_name = ".Get108BonusReply.id"
Activity108Module_pb.GET108BONUSREPLYIDFIELD.number = 2
Activity108Module_pb.GET108BONUSREPLYIDFIELD.index = 1
Activity108Module_pb.GET108BONUSREPLYIDFIELD.label = 1
Activity108Module_pb.GET108BONUSREPLYIDFIELD.has_default_value = false
Activity108Module_pb.GET108BONUSREPLYIDFIELD.default_value = 0
Activity108Module_pb.GET108BONUSREPLYIDFIELD.type = 5
Activity108Module_pb.GET108BONUSREPLYIDFIELD.cpp_type = 1
Activity108Module_pb.GET108BONUSREPLY_MSG.name = "Get108BonusReply"
Activity108Module_pb.GET108BONUSREPLY_MSG.full_name = ".Get108BonusReply"
Activity108Module_pb.GET108BONUSREPLY_MSG.nested_types = {}
Activity108Module_pb.GET108BONUSREPLY_MSG.enum_types = {}
Activity108Module_pb.GET108BONUSREPLY_MSG.fields = {
	Activity108Module_pb.GET108BONUSREPLYACTIVITYIDFIELD,
	Activity108Module_pb.GET108BONUSREPLYIDFIELD
}
Activity108Module_pb.GET108BONUSREPLY_MSG.is_extendable = false
Activity108Module_pb.GET108BONUSREPLY_MSG.extensions = {}
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.full_name = ".EpisodeConfirmReply.activityId"
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.number = 1
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.index = 0
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.label = 1
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.type = 5
Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.name = "episodeId"
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.full_name = ".EpisodeConfirmReply.episodeId"
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.number = 2
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.index = 1
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.label = 1
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.has_default_value = false
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.default_value = 0
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.type = 5
Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.name = "EpisodeConfirmReply"
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.full_name = ".EpisodeConfirmReply"
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.nested_types = {}
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.enum_types = {}
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.fields = {
	Activity108Module_pb.EPISODECONFIRMREPLYACTIVITYIDFIELD,
	Activity108Module_pb.EPISODECONFIRMREPLYEPISODEIDFIELD
}
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.is_extendable = false
Activity108Module_pb.EPISODECONFIRMREPLY_MSG.extensions = {}
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.name = "activityId"
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.full_name = ".EpisodeConfirmRequest.activityId"
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.number = 1
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.index = 0
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.label = 1
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.has_default_value = false
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.default_value = 0
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.type = 5
Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.name = "episodeId"
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.full_name = ".EpisodeConfirmRequest.episodeId"
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.number = 2
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.index = 1
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.label = 1
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.has_default_value = false
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.default_value = 0
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.type = 5
Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD.cpp_type = 1
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.name = "EpisodeConfirmRequest"
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.full_name = ".EpisodeConfirmRequest"
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.nested_types = {}
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.enum_types = {}
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.fields = {
	Activity108Module_pb.EPISODECONFIRMREQUESTACTIVITYIDFIELD,
	Activity108Module_pb.EPISODECONFIRMREQUESTEPISODEIDFIELD
}
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.is_extendable = false
Activity108Module_pb.EPISODECONFIRMREQUEST_MSG.extensions = {}
Activity108Module_pb.DialogEventSelectReply = protobuf.Message(Activity108Module_pb.DIALOGEVENTSELECTREPLY_MSG)
Activity108Module_pb.DialogEventSelectRequest = protobuf.Message(Activity108Module_pb.DIALOGEVENTSELECTREQUEST_MSG)
Activity108Module_pb.EnterFightEventReply = protobuf.Message(Activity108Module_pb.ENTERFIGHTEVENTREPLY_MSG)
Activity108Module_pb.EnterFightEventRequest = protobuf.Message(Activity108Module_pb.ENTERFIGHTEVENTREQUEST_MSG)
Activity108Module_pb.EpisodeConfirmReply = protobuf.Message(Activity108Module_pb.EPISODECONFIRMREPLY_MSG)
Activity108Module_pb.EpisodeConfirmRequest = protobuf.Message(Activity108Module_pb.EPISODECONFIRMREQUEST_MSG)
Activity108Module_pb.EpisodeEvent = protobuf.Message(Activity108Module_pb.EPISODEEVENT_MSG)
Activity108Module_pb.EpisodeHistory = protobuf.Message(Activity108Module_pb.EPISODEHISTORY_MSG)
Activity108Module_pb.EpisodeInfo = protobuf.Message(Activity108Module_pb.EPISODEINFO_MSG)
Activity108Module_pb.EpisodeUpdatePush = protobuf.Message(Activity108Module_pb.EPISODEUPDATEPUSH_MSG)
Activity108Module_pb.EventHistory = protobuf.Message(Activity108Module_pb.EVENTHISTORY_MSG)
Activity108Module_pb.Get108BonusReply = protobuf.Message(Activity108Module_pb.GET108BONUSREPLY_MSG)
Activity108Module_pb.Get108BonusRequest = protobuf.Message(Activity108Module_pb.GET108BONUSREQUEST_MSG)
Activity108Module_pb.Get108InfosReply = protobuf.Message(Activity108Module_pb.GET108INFOSREPLY_MSG)
Activity108Module_pb.Get108InfosRequest = protobuf.Message(Activity108Module_pb.GET108INFOSREQUEST_MSG)
Activity108Module_pb.InfoUpdatePush = protobuf.Message(Activity108Module_pb.INFOUPDATEPUSH_MSG)
Activity108Module_pb.MapInfo = protobuf.Message(Activity108Module_pb.MAPINFO_MSG)
Activity108Module_pb.ResetMapReply = protobuf.Message(Activity108Module_pb.RESETMAPREPLY_MSG)
Activity108Module_pb.ResetMapRequest = protobuf.Message(Activity108Module_pb.RESETMAPREQUEST_MSG)

return Activity108Module_pb
