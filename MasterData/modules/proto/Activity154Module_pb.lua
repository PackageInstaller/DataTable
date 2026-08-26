-- chunkname: @modules/proto/Activity154Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity154Module_pb", package.seeall)

local Activity154Module_pb = {}

Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG = protobuf.Descriptor()
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.GET154INFOSREQUEST_MSG = protobuf.Descriptor()
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.PUZZLEINFO_MSG = protobuf.Descriptor()
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.PUZZLEINFOSTATEFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.GET154INFOSREPLY_MSG = protobuf.Descriptor()
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG = protobuf.Descriptor()
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD = protobuf.FieldDescriptor()
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.name = "activityId"
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.full_name = ".Answer154PuzzleReply.activityId"
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.number = 1
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.index = 0
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.label = 1
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.has_default_value = false
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.default_value = 0
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.type = 5
Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.name = "info"
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.full_name = ".Answer154PuzzleReply.info"
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.number = 2
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.index = 1
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.label = 1
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.has_default_value = false
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.default_value = nil
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.message_type = Activity154Module_pb.PUZZLEINFO_MSG
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.type = 11
Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD.cpp_type = 10
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.name = "Answer154PuzzleReply"
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.full_name = ".Answer154PuzzleReply"
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.nested_types = {}
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.enum_types = {}
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.fields = {
	Activity154Module_pb.ANSWER154PUZZLEREPLYACTIVITYIDFIELD,
	Activity154Module_pb.ANSWER154PUZZLEREPLYINFOFIELD
}
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.is_extendable = false
Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG.extensions = {}
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get154InfosRequest.activityId"
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.number = 1
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.index = 0
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.label = 1
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.default_value = 0
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.type = 5
Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity154Module_pb.GET154INFOSREQUEST_MSG.name = "Get154InfosRequest"
Activity154Module_pb.GET154INFOSREQUEST_MSG.full_name = ".Get154InfosRequest"
Activity154Module_pb.GET154INFOSREQUEST_MSG.nested_types = {}
Activity154Module_pb.GET154INFOSREQUEST_MSG.enum_types = {}
Activity154Module_pb.GET154INFOSREQUEST_MSG.fields = {
	Activity154Module_pb.GET154INFOSREQUESTACTIVITYIDFIELD
}
Activity154Module_pb.GET154INFOSREQUEST_MSG.is_extendable = false
Activity154Module_pb.GET154INFOSREQUEST_MSG.extensions = {}
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.name = "puzzleId"
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.full_name = ".PuzzleInfo.puzzleId"
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.number = 1
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.index = 0
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.label = 1
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.has_default_value = false
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.default_value = 0
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.type = 13
Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD.cpp_type = 3
Activity154Module_pb.PUZZLEINFOSTATEFIELD.name = "state"
Activity154Module_pb.PUZZLEINFOSTATEFIELD.full_name = ".PuzzleInfo.state"
Activity154Module_pb.PUZZLEINFOSTATEFIELD.number = 2
Activity154Module_pb.PUZZLEINFOSTATEFIELD.index = 1
Activity154Module_pb.PUZZLEINFOSTATEFIELD.label = 1
Activity154Module_pb.PUZZLEINFOSTATEFIELD.has_default_value = false
Activity154Module_pb.PUZZLEINFOSTATEFIELD.default_value = 0
Activity154Module_pb.PUZZLEINFOSTATEFIELD.type = 13
Activity154Module_pb.PUZZLEINFOSTATEFIELD.cpp_type = 3
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.name = "answerRecords"
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.full_name = ".PuzzleInfo.answerRecords"
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.number = 3
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.index = 2
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.label = 3
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.has_default_value = false
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.default_value = {}
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.type = 13
Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD.cpp_type = 3
Activity154Module_pb.PUZZLEINFO_MSG.name = "PuzzleInfo"
Activity154Module_pb.PUZZLEINFO_MSG.full_name = ".PuzzleInfo"
Activity154Module_pb.PUZZLEINFO_MSG.nested_types = {}
Activity154Module_pb.PUZZLEINFO_MSG.enum_types = {}
Activity154Module_pb.PUZZLEINFO_MSG.fields = {
	Activity154Module_pb.PUZZLEINFOPUZZLEIDFIELD,
	Activity154Module_pb.PUZZLEINFOSTATEFIELD,
	Activity154Module_pb.PUZZLEINFOANSWERRECORDSFIELD
}
Activity154Module_pb.PUZZLEINFO_MSG.is_extendable = false
Activity154Module_pb.PUZZLEINFO_MSG.extensions = {}
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.name = "activityId"
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.full_name = ".Get154InfosReply.activityId"
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.number = 1
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.index = 0
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.label = 1
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.has_default_value = false
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.default_value = 0
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.type = 5
Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.name = "loginCount"
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.full_name = ".Get154InfosReply.loginCount"
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.number = 2
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.index = 1
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.label = 1
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.has_default_value = false
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.default_value = 0
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.type = 13
Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD.cpp_type = 3
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.name = "infos"
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.full_name = ".Get154InfosReply.infos"
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.number = 3
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.index = 2
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.label = 3
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.has_default_value = false
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.default_value = {}
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.message_type = Activity154Module_pb.PUZZLEINFO_MSG
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.type = 11
Activity154Module_pb.GET154INFOSREPLYINFOSFIELD.cpp_type = 10
Activity154Module_pb.GET154INFOSREPLY_MSG.name = "Get154InfosReply"
Activity154Module_pb.GET154INFOSREPLY_MSG.full_name = ".Get154InfosReply"
Activity154Module_pb.GET154INFOSREPLY_MSG.nested_types = {}
Activity154Module_pb.GET154INFOSREPLY_MSG.enum_types = {}
Activity154Module_pb.GET154INFOSREPLY_MSG.fields = {
	Activity154Module_pb.GET154INFOSREPLYACTIVITYIDFIELD,
	Activity154Module_pb.GET154INFOSREPLYLOGINCOUNTFIELD,
	Activity154Module_pb.GET154INFOSREPLYINFOSFIELD
}
Activity154Module_pb.GET154INFOSREPLY_MSG.is_extendable = false
Activity154Module_pb.GET154INFOSREPLY_MSG.extensions = {}
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.full_name = ".Answer154PuzzleRequest.activityId"
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.number = 1
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.index = 0
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.label = 1
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.default_value = 0
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.type = 5
Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.name = "puzzleId"
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.full_name = ".Answer154PuzzleRequest.puzzleId"
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.number = 2
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.index = 1
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.label = 1
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.has_default_value = false
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.default_value = 0
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.type = 13
Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD.cpp_type = 3
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.name = "optionId"
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.full_name = ".Answer154PuzzleRequest.optionId"
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.number = 3
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.index = 2
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.label = 1
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.has_default_value = false
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.default_value = 0
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.type = 13
Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD.cpp_type = 3
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.name = "Answer154PuzzleRequest"
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.full_name = ".Answer154PuzzleRequest"
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.nested_types = {}
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.enum_types = {}
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.fields = {
	Activity154Module_pb.ANSWER154PUZZLEREQUESTACTIVITYIDFIELD,
	Activity154Module_pb.ANSWER154PUZZLEREQUESTPUZZLEIDFIELD,
	Activity154Module_pb.ANSWER154PUZZLEREQUESTOPTIONIDFIELD
}
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.is_extendable = false
Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG.extensions = {}
Activity154Module_pb.Answer154PuzzleReply = protobuf.Message(Activity154Module_pb.ANSWER154PUZZLEREPLY_MSG)
Activity154Module_pb.Answer154PuzzleRequest = protobuf.Message(Activity154Module_pb.ANSWER154PUZZLEREQUEST_MSG)
Activity154Module_pb.Get154InfosReply = protobuf.Message(Activity154Module_pb.GET154INFOSREPLY_MSG)
Activity154Module_pb.Get154InfosRequest = protobuf.Message(Activity154Module_pb.GET154INFOSREQUEST_MSG)
Activity154Module_pb.PuzzleInfo = protobuf.Message(Activity154Module_pb.PUZZLEINFO_MSG)

return Activity154Module_pb
