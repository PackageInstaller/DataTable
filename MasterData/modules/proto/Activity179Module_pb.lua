-- chunkname: @modules/proto/Activity179Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity179Module_pb", package.seeall)

local Activity179Module_pb = {}

Activity179Module_pb.ACT179EPISODENO_MSG = protobuf.Descriptor()
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.GET179INFOSREQUEST_MSG = protobuf.Descriptor()
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.SET179SCOREREPLY_MSG = protobuf.Descriptor()
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.SET179SCOREREQUEST_MSG = protobuf.Descriptor()
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.GET179INFOSREPLY_MSG = protobuf.Descriptor()
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD = protobuf.FieldDescriptor()
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.name = "episodeId"
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.full_name = ".Act179EpisodeNO.episodeId"
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.number = 1
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.index = 0
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.label = 1
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.has_default_value = false
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.default_value = 0
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.type = 5
Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD.cpp_type = 1
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.name = "isFinished"
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.full_name = ".Act179EpisodeNO.isFinished"
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.number = 2
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.index = 1
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.label = 1
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.has_default_value = false
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.default_value = false
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.type = 8
Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD.cpp_type = 7
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.name = "highScore"
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.full_name = ".Act179EpisodeNO.highScore"
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.number = 3
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.index = 2
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.label = 1
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.has_default_value = false
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.default_value = 0
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.type = 5
Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD.cpp_type = 1
Activity179Module_pb.ACT179EPISODENO_MSG.name = "Act179EpisodeNO"
Activity179Module_pb.ACT179EPISODENO_MSG.full_name = ".Act179EpisodeNO"
Activity179Module_pb.ACT179EPISODENO_MSG.nested_types = {}
Activity179Module_pb.ACT179EPISODENO_MSG.enum_types = {}
Activity179Module_pb.ACT179EPISODENO_MSG.fields = {
	Activity179Module_pb.ACT179EPISODENOEPISODEIDFIELD,
	Activity179Module_pb.ACT179EPISODENOISFINISHEDFIELD,
	Activity179Module_pb.ACT179EPISODENOHIGHSCOREFIELD
}
Activity179Module_pb.ACT179EPISODENO_MSG.is_extendable = false
Activity179Module_pb.ACT179EPISODENO_MSG.extensions = {}
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get179InfosRequest.activityId"
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity179Module_pb.GET179INFOSREQUEST_MSG.name = "Get179InfosRequest"
Activity179Module_pb.GET179INFOSREQUEST_MSG.full_name = ".Get179InfosRequest"
Activity179Module_pb.GET179INFOSREQUEST_MSG.nested_types = {}
Activity179Module_pb.GET179INFOSREQUEST_MSG.enum_types = {}
Activity179Module_pb.GET179INFOSREQUEST_MSG.fields = {
	Activity179Module_pb.GET179INFOSREQUESTACTIVITYIDFIELD
}
Activity179Module_pb.GET179INFOSREQUEST_MSG.is_extendable = false
Activity179Module_pb.GET179INFOSREQUEST_MSG.extensions = {}
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.name = "activityId"
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.full_name = ".Set179ScoreReply.activityId"
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.number = 1
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.index = 0
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.label = 1
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.has_default_value = false
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.default_value = 0
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.type = 5
Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD.cpp_type = 1
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.name = "act179EpisodeNO"
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.full_name = ".Set179ScoreReply.act179EpisodeNO"
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.number = 2
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.index = 1
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.label = 1
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.has_default_value = false
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.default_value = nil
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.message_type = Activity179Module_pb.ACT179EPISODENO_MSG
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.type = 11
Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD.cpp_type = 10
Activity179Module_pb.SET179SCOREREPLY_MSG.name = "Set179ScoreReply"
Activity179Module_pb.SET179SCOREREPLY_MSG.full_name = ".Set179ScoreReply"
Activity179Module_pb.SET179SCOREREPLY_MSG.nested_types = {}
Activity179Module_pb.SET179SCOREREPLY_MSG.enum_types = {}
Activity179Module_pb.SET179SCOREREPLY_MSG.fields = {
	Activity179Module_pb.SET179SCOREREPLYACTIVITYIDFIELD,
	Activity179Module_pb.SET179SCOREREPLYACT179EPISODENOFIELD
}
Activity179Module_pb.SET179SCOREREPLY_MSG.is_extendable = false
Activity179Module_pb.SET179SCOREREPLY_MSG.extensions = {}
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.name = "activityId"
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.full_name = ".Set179ScoreRequest.activityId"
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.number = 1
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.index = 0
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.label = 1
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.has_default_value = false
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.default_value = 0
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.type = 5
Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.name = "episodeId"
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.full_name = ".Set179ScoreRequest.episodeId"
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.number = 2
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.index = 1
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.label = 1
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.has_default_value = false
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.default_value = 0
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.type = 5
Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD.cpp_type = 1
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.name = "score"
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.full_name = ".Set179ScoreRequest.score"
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.number = 3
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.index = 2
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.label = 1
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.has_default_value = false
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.default_value = 0
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.type = 5
Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD.cpp_type = 1
Activity179Module_pb.SET179SCOREREQUEST_MSG.name = "Set179ScoreRequest"
Activity179Module_pb.SET179SCOREREQUEST_MSG.full_name = ".Set179ScoreRequest"
Activity179Module_pb.SET179SCOREREQUEST_MSG.nested_types = {}
Activity179Module_pb.SET179SCOREREQUEST_MSG.enum_types = {}
Activity179Module_pb.SET179SCOREREQUEST_MSG.fields = {
	Activity179Module_pb.SET179SCOREREQUESTACTIVITYIDFIELD,
	Activity179Module_pb.SET179SCOREREQUESTEPISODEIDFIELD,
	Activity179Module_pb.SET179SCOREREQUESTSCOREFIELD
}
Activity179Module_pb.SET179SCOREREQUEST_MSG.is_extendable = false
Activity179Module_pb.SET179SCOREREQUEST_MSG.extensions = {}
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.full_name = ".Get179InfosReply.activityId"
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.number = 1
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.index = 0
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.label = 1
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.type = 5
Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.name = "act179EpisodeNO"
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.full_name = ".Get179InfosReply.act179EpisodeNO"
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.number = 2
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.index = 1
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.label = 3
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.has_default_value = false
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.default_value = {}
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.message_type = Activity179Module_pb.ACT179EPISODENO_MSG
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.type = 11
Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD.cpp_type = 10
Activity179Module_pb.GET179INFOSREPLY_MSG.name = "Get179InfosReply"
Activity179Module_pb.GET179INFOSREPLY_MSG.full_name = ".Get179InfosReply"
Activity179Module_pb.GET179INFOSREPLY_MSG.nested_types = {}
Activity179Module_pb.GET179INFOSREPLY_MSG.enum_types = {}
Activity179Module_pb.GET179INFOSREPLY_MSG.fields = {
	Activity179Module_pb.GET179INFOSREPLYACTIVITYIDFIELD,
	Activity179Module_pb.GET179INFOSREPLYACT179EPISODENOFIELD
}
Activity179Module_pb.GET179INFOSREPLY_MSG.is_extendable = false
Activity179Module_pb.GET179INFOSREPLY_MSG.extensions = {}
Activity179Module_pb.Act179EpisodeNO = protobuf.Message(Activity179Module_pb.ACT179EPISODENO_MSG)
Activity179Module_pb.Get179InfosReply = protobuf.Message(Activity179Module_pb.GET179INFOSREPLY_MSG)
Activity179Module_pb.Get179InfosRequest = protobuf.Message(Activity179Module_pb.GET179INFOSREQUEST_MSG)
Activity179Module_pb.Set179ScoreReply = protobuf.Message(Activity179Module_pb.SET179SCOREREPLY_MSG)
Activity179Module_pb.Set179ScoreRequest = protobuf.Message(Activity179Module_pb.SET179SCOREREQUEST_MSG)

return Activity179Module_pb
