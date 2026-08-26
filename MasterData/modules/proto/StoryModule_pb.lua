-- chunkname: @modules/proto/StoryModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.StoryModule_pb", package.seeall)

local StoryModule_pb = {}

StoryModule_pb.HERODEF_PB = require("modules.proto.HeroDef_pb")
StoryModule_pb.GETSTORYFINISHREQUEST_MSG = protobuf.Descriptor()
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD = protobuf.FieldDescriptor()
StoryModule_pb.PROCESSINGSTORYINFO_MSG = protobuf.Descriptor()
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD = protobuf.FieldDescriptor()
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD = protobuf.FieldDescriptor()
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD = protobuf.FieldDescriptor()
StoryModule_pb.UPDATESTORYREQUEST_MSG = protobuf.Descriptor()
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD = protobuf.FieldDescriptor()
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD = protobuf.FieldDescriptor()
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD = protobuf.FieldDescriptor()
StoryModule_pb.GETSTORYFINISHREPLY_MSG = protobuf.Descriptor()
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD = protobuf.FieldDescriptor()
StoryModule_pb.UPDATESTORYREPLY_MSG = protobuf.Descriptor()
StoryModule_pb.GETSTORYREQUEST_MSG = protobuf.Descriptor()
StoryModule_pb.STORYFINISHPUSH_MSG = protobuf.Descriptor()
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD = protobuf.FieldDescriptor()
StoryModule_pb.GETSTORYREPLY_MSG = protobuf.Descriptor()
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD = protobuf.FieldDescriptor()
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD = protobuf.FieldDescriptor()
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.name = "storyId"
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.full_name = ".GetStoryFinishRequest.storyId"
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.number = 1
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.index = 0
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.label = 1
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.has_default_value = false
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.default_value = 0
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.type = 5
StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD.cpp_type = 1
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.name = "GetStoryFinishRequest"
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.full_name = ".GetStoryFinishRequest"
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.nested_types = {}
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.enum_types = {}
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.fields = {
	StoryModule_pb.GETSTORYFINISHREQUESTSTORYIDFIELD
}
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.is_extendable = false
StoryModule_pb.GETSTORYFINISHREQUEST_MSG.extensions = {}
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.name = "storyId"
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.full_name = ".ProcessingStoryInfo.storyId"
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.number = 1
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.index = 0
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.label = 1
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.has_default_value = false
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.default_value = 0
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.type = 5
StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD.cpp_type = 1
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.name = "stepId"
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.full_name = ".ProcessingStoryInfo.stepId"
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.number = 2
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.index = 1
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.label = 1
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.has_default_value = false
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.default_value = 0
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.type = 5
StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD.cpp_type = 1
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.name = "favor"
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.full_name = ".ProcessingStoryInfo.favor"
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.number = 3
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.index = 2
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.label = 1
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.has_default_value = false
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.default_value = 0
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.type = 5
StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD.cpp_type = 1
StoryModule_pb.PROCESSINGSTORYINFO_MSG.name = "ProcessingStoryInfo"
StoryModule_pb.PROCESSINGSTORYINFO_MSG.full_name = ".ProcessingStoryInfo"
StoryModule_pb.PROCESSINGSTORYINFO_MSG.nested_types = {}
StoryModule_pb.PROCESSINGSTORYINFO_MSG.enum_types = {}
StoryModule_pb.PROCESSINGSTORYINFO_MSG.fields = {
	StoryModule_pb.PROCESSINGSTORYINFOSTORYIDFIELD,
	StoryModule_pb.PROCESSINGSTORYINFOSTEPIDFIELD,
	StoryModule_pb.PROCESSINGSTORYINFOFAVORFIELD
}
StoryModule_pb.PROCESSINGSTORYINFO_MSG.is_extendable = false
StoryModule_pb.PROCESSINGSTORYINFO_MSG.extensions = {}
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.name = "storyId"
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.full_name = ".UpdateStoryRequest.storyId"
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.number = 1
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.index = 0
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.label = 1
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.has_default_value = false
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.default_value = 0
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.type = 5
StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD.cpp_type = 1
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.name = "stepId"
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.full_name = ".UpdateStoryRequest.stepId"
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.number = 2
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.index = 1
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.label = 1
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.has_default_value = false
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.default_value = 0
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.type = 5
StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD.cpp_type = 1
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.name = "favor"
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.full_name = ".UpdateStoryRequest.favor"
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.number = 3
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.index = 2
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.label = 1
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.has_default_value = false
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.default_value = 0
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.type = 5
StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD.cpp_type = 1
StoryModule_pb.UPDATESTORYREQUEST_MSG.name = "UpdateStoryRequest"
StoryModule_pb.UPDATESTORYREQUEST_MSG.full_name = ".UpdateStoryRequest"
StoryModule_pb.UPDATESTORYREQUEST_MSG.nested_types = {}
StoryModule_pb.UPDATESTORYREQUEST_MSG.enum_types = {}
StoryModule_pb.UPDATESTORYREQUEST_MSG.fields = {
	StoryModule_pb.UPDATESTORYREQUESTSTORYIDFIELD,
	StoryModule_pb.UPDATESTORYREQUESTSTEPIDFIELD,
	StoryModule_pb.UPDATESTORYREQUESTFAVORFIELD
}
StoryModule_pb.UPDATESTORYREQUEST_MSG.is_extendable = false
StoryModule_pb.UPDATESTORYREQUEST_MSG.extensions = {}
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.name = "isFinish"
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.full_name = ".GetStoryFinishReply.isFinish"
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.number = 1
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.index = 0
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.label = 1
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.has_default_value = false
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.default_value = false
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.type = 8
StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD.cpp_type = 7
StoryModule_pb.GETSTORYFINISHREPLY_MSG.name = "GetStoryFinishReply"
StoryModule_pb.GETSTORYFINISHREPLY_MSG.full_name = ".GetStoryFinishReply"
StoryModule_pb.GETSTORYFINISHREPLY_MSG.nested_types = {}
StoryModule_pb.GETSTORYFINISHREPLY_MSG.enum_types = {}
StoryModule_pb.GETSTORYFINISHREPLY_MSG.fields = {
	StoryModule_pb.GETSTORYFINISHREPLYISFINISHFIELD
}
StoryModule_pb.GETSTORYFINISHREPLY_MSG.is_extendable = false
StoryModule_pb.GETSTORYFINISHREPLY_MSG.extensions = {}
StoryModule_pb.UPDATESTORYREPLY_MSG.name = "UpdateStoryReply"
StoryModule_pb.UPDATESTORYREPLY_MSG.full_name = ".UpdateStoryReply"
StoryModule_pb.UPDATESTORYREPLY_MSG.nested_types = {}
StoryModule_pb.UPDATESTORYREPLY_MSG.enum_types = {}
StoryModule_pb.UPDATESTORYREPLY_MSG.fields = {}
StoryModule_pb.UPDATESTORYREPLY_MSG.is_extendable = false
StoryModule_pb.UPDATESTORYREPLY_MSG.extensions = {}
StoryModule_pb.GETSTORYREQUEST_MSG.name = "GetStoryRequest"
StoryModule_pb.GETSTORYREQUEST_MSG.full_name = ".GetStoryRequest"
StoryModule_pb.GETSTORYREQUEST_MSG.nested_types = {}
StoryModule_pb.GETSTORYREQUEST_MSG.enum_types = {}
StoryModule_pb.GETSTORYREQUEST_MSG.fields = {}
StoryModule_pb.GETSTORYREQUEST_MSG.is_extendable = false
StoryModule_pb.GETSTORYREQUEST_MSG.extensions = {}
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.name = "storyId"
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.full_name = ".StoryFinishPush.storyId"
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.number = 1
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.index = 0
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.label = 1
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.has_default_value = false
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.default_value = 0
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.type = 5
StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD.cpp_type = 1
StoryModule_pb.STORYFINISHPUSH_MSG.name = "StoryFinishPush"
StoryModule_pb.STORYFINISHPUSH_MSG.full_name = ".StoryFinishPush"
StoryModule_pb.STORYFINISHPUSH_MSG.nested_types = {}
StoryModule_pb.STORYFINISHPUSH_MSG.enum_types = {}
StoryModule_pb.STORYFINISHPUSH_MSG.fields = {
	StoryModule_pb.STORYFINISHPUSHSTORYIDFIELD
}
StoryModule_pb.STORYFINISHPUSH_MSG.is_extendable = false
StoryModule_pb.STORYFINISHPUSH_MSG.extensions = {}
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.name = "finishList"
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.full_name = ".GetStoryReply.finishList"
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.number = 1
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.index = 0
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.label = 3
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.has_default_value = false
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.default_value = {}
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.type = 5
StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD.cpp_type = 1
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.name = "processingList"
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.full_name = ".GetStoryReply.processingList"
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.number = 2
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.index = 1
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.label = 3
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.has_default_value = false
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.default_value = {}
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.message_type = StoryModule_pb.PROCESSINGSTORYINFO_MSG
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.type = 11
StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD.cpp_type = 10
StoryModule_pb.GETSTORYREPLY_MSG.name = "GetStoryReply"
StoryModule_pb.GETSTORYREPLY_MSG.full_name = ".GetStoryReply"
StoryModule_pb.GETSTORYREPLY_MSG.nested_types = {}
StoryModule_pb.GETSTORYREPLY_MSG.enum_types = {}
StoryModule_pb.GETSTORYREPLY_MSG.fields = {
	StoryModule_pb.GETSTORYREPLYFINISHLISTFIELD,
	StoryModule_pb.GETSTORYREPLYPROCESSINGLISTFIELD
}
StoryModule_pb.GETSTORYREPLY_MSG.is_extendable = false
StoryModule_pb.GETSTORYREPLY_MSG.extensions = {}
StoryModule_pb.GetStoryFinishReply = protobuf.Message(StoryModule_pb.GETSTORYFINISHREPLY_MSG)
StoryModule_pb.GetStoryFinishRequest = protobuf.Message(StoryModule_pb.GETSTORYFINISHREQUEST_MSG)
StoryModule_pb.GetStoryReply = protobuf.Message(StoryModule_pb.GETSTORYREPLY_MSG)
StoryModule_pb.GetStoryRequest = protobuf.Message(StoryModule_pb.GETSTORYREQUEST_MSG)
StoryModule_pb.ProcessingStoryInfo = protobuf.Message(StoryModule_pb.PROCESSINGSTORYINFO_MSG)
StoryModule_pb.StoryFinishPush = protobuf.Message(StoryModule_pb.STORYFINISHPUSH_MSG)
StoryModule_pb.UpdateStoryReply = protobuf.Message(StoryModule_pb.UPDATESTORYREPLY_MSG)
StoryModule_pb.UpdateStoryRequest = protobuf.Message(StoryModule_pb.UPDATESTORYREQUEST_MSG)

return StoryModule_pb
