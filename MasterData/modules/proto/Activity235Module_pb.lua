-- chunkname: @modules/proto/Activity235Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity235Module_pb", package.seeall)

local Activity235Module_pb = {}

Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG = protobuf.Descriptor()
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACT235INFO_MSG = protobuf.Descriptor()
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG = protobuf.Descriptor()
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.GETACT235INFOREPLY_MSG = protobuf.Descriptor()
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG = protobuf.Descriptor()
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACT235TYPECOUNT_MSG = protobuf.Descriptor()
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.GETACT235INFOREQUEST_MSG = protobuf.Descriptor()
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG = protobuf.Descriptor()
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD = protobuf.FieldDescriptor()
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.full_name = ".FinishMiniGameRequest.activityId"
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.number = 1
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.index = 0
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.label = 1
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.default_value = 0
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.type = 5
Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.name = "countList"
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.full_name = ".FinishMiniGameRequest.countList"
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.number = 2
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.index = 1
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.label = 3
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.has_default_value = false
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.default_value = {}
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.message_type = Activity235Module_pb.ACT235TYPECOUNT_MSG
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.type = 11
Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD.cpp_type = 10
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.name = "FinishMiniGameRequest"
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.full_name = ".FinishMiniGameRequest"
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.nested_types = {}
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.enum_types = {}
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.fields = {
	Activity235Module_pb.FINISHMINIGAMEREQUESTACTIVITYIDFIELD,
	Activity235Module_pb.FINISHMINIGAMEREQUESTCOUNTLISTFIELD
}
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.is_extendable = false
Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG.extensions = {}
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.name = "totalRewardCount"
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.full_name = ".Act235Info.totalRewardCount"
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.number = 1
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.index = 0
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.label = 1
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.has_default_value = false
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.default_value = 0
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.type = 5
Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD.cpp_type = 1
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.name = "preparationIds"
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.full_name = ".Act235Info.preparationIds"
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.number = 2
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.index = 1
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.label = 3
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.has_default_value = false
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.default_value = {}
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.type = 5
Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD.cpp_type = 1
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.name = "countList"
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.full_name = ".Act235Info.countList"
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.number = 3
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.index = 2
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.label = 3
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.has_default_value = false
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.default_value = {}
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.message_type = Activity235Module_pb.ACT235TYPECOUNT_MSG
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.type = 11
Activity235Module_pb.ACT235INFOCOUNTLISTFIELD.cpp_type = 10
Activity235Module_pb.ACT235INFO_MSG.name = "Act235Info"
Activity235Module_pb.ACT235INFO_MSG.full_name = ".Act235Info"
Activity235Module_pb.ACT235INFO_MSG.nested_types = {}
Activity235Module_pb.ACT235INFO_MSG.enum_types = {}
Activity235Module_pb.ACT235INFO_MSG.fields = {
	Activity235Module_pb.ACT235INFOTOTALREWARDCOUNTFIELD,
	Activity235Module_pb.ACT235INFOPREPARATIONIDSFIELD,
	Activity235Module_pb.ACT235INFOCOUNTLISTFIELD
}
Activity235Module_pb.ACT235INFO_MSG.is_extendable = false
Activity235Module_pb.ACT235INFO_MSG.extensions = {}
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.name = "info"
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.full_name = ".ActivePreparationReply.info"
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.number = 1
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.index = 0
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.label = 1
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.has_default_value = false
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.default_value = nil
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.message_type = Activity235Module_pb.ACT235INFO_MSG
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.type = 11
Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD.cpp_type = 10
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.name = "ActivePreparationReply"
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.full_name = ".ActivePreparationReply"
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.nested_types = {}
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.enum_types = {}
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.fields = {
	Activity235Module_pb.ACTIVEPREPARATIONREPLYINFOFIELD
}
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.is_extendable = false
Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG.extensions = {}
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct235InfoReply.activityId"
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.number = 1
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.index = 0
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.label = 1
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.type = 5
Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.name = "info"
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.full_name = ".GetAct235InfoReply.info"
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.number = 2
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.index = 1
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.label = 1
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.has_default_value = false
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.default_value = nil
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.message_type = Activity235Module_pb.ACT235INFO_MSG
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.type = 11
Activity235Module_pb.GETACT235INFOREPLYINFOFIELD.cpp_type = 10
Activity235Module_pb.GETACT235INFOREPLY_MSG.name = "GetAct235InfoReply"
Activity235Module_pb.GETACT235INFOREPLY_MSG.full_name = ".GetAct235InfoReply"
Activity235Module_pb.GETACT235INFOREPLY_MSG.nested_types = {}
Activity235Module_pb.GETACT235INFOREPLY_MSG.enum_types = {}
Activity235Module_pb.GETACT235INFOREPLY_MSG.fields = {
	Activity235Module_pb.GETACT235INFOREPLYACTIVITYIDFIELD,
	Activity235Module_pb.GETACT235INFOREPLYINFOFIELD
}
Activity235Module_pb.GETACT235INFOREPLY_MSG.is_extendable = false
Activity235Module_pb.GETACT235INFOREPLY_MSG.extensions = {}
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.name = "activityId"
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.full_name = ".ActivePreparationRequest.activityId"
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.number = 1
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.index = 0
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.label = 1
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.has_default_value = false
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.default_value = 0
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.type = 5
Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.name = "preparationId"
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.full_name = ".ActivePreparationRequest.preparationId"
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.number = 2
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.index = 1
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.label = 1
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.has_default_value = false
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.default_value = 0
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.type = 5
Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD.cpp_type = 1
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.name = "ActivePreparationRequest"
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.full_name = ".ActivePreparationRequest"
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.nested_types = {}
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.enum_types = {}
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.fields = {
	Activity235Module_pb.ACTIVEPREPARATIONREQUESTACTIVITYIDFIELD,
	Activity235Module_pb.ACTIVEPREPARATIONREQUESTPREPARATIONIDFIELD
}
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.is_extendable = false
Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG.extensions = {}
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.name = "type"
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.full_name = ".Act235TypeCount.type"
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.number = 1
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.index = 0
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.label = 1
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.has_default_value = false
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.default_value = 0
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.type = 5
Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD.cpp_type = 1
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.name = "count"
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.full_name = ".Act235TypeCount.count"
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.number = 2
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.index = 1
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.label = 1
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.has_default_value = false
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.default_value = 0
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.type = 5
Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD.cpp_type = 1
Activity235Module_pb.ACT235TYPECOUNT_MSG.name = "Act235TypeCount"
Activity235Module_pb.ACT235TYPECOUNT_MSG.full_name = ".Act235TypeCount"
Activity235Module_pb.ACT235TYPECOUNT_MSG.nested_types = {}
Activity235Module_pb.ACT235TYPECOUNT_MSG.enum_types = {}
Activity235Module_pb.ACT235TYPECOUNT_MSG.fields = {
	Activity235Module_pb.ACT235TYPECOUNTTYPEFIELD,
	Activity235Module_pb.ACT235TYPECOUNTCOUNTFIELD
}
Activity235Module_pb.ACT235TYPECOUNT_MSG.is_extendable = false
Activity235Module_pb.ACT235TYPECOUNT_MSG.extensions = {}
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct235InfoRequest.activityId"
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.number = 1
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.index = 0
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.label = 1
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.type = 5
Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity235Module_pb.GETACT235INFOREQUEST_MSG.name = "GetAct235InfoRequest"
Activity235Module_pb.GETACT235INFOREQUEST_MSG.full_name = ".GetAct235InfoRequest"
Activity235Module_pb.GETACT235INFOREQUEST_MSG.nested_types = {}
Activity235Module_pb.GETACT235INFOREQUEST_MSG.enum_types = {}
Activity235Module_pb.GETACT235INFOREQUEST_MSG.fields = {
	Activity235Module_pb.GETACT235INFOREQUESTACTIVITYIDFIELD
}
Activity235Module_pb.GETACT235INFOREQUEST_MSG.is_extendable = false
Activity235Module_pb.GETACT235INFOREQUEST_MSG.extensions = {}
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.name = "info"
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.full_name = ".FinishMiniGameReply.info"
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.number = 1
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.index = 0
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.label = 1
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.has_default_value = false
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.default_value = nil
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.message_type = Activity235Module_pb.ACT235INFO_MSG
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.type = 11
Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD.cpp_type = 10
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.name = "FinishMiniGameReply"
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.full_name = ".FinishMiniGameReply"
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.nested_types = {}
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.enum_types = {}
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.fields = {
	Activity235Module_pb.FINISHMINIGAMEREPLYINFOFIELD
}
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.is_extendable = false
Activity235Module_pb.FINISHMINIGAMEREPLY_MSG.extensions = {}
Activity235Module_pb.Act235Info = protobuf.Message(Activity235Module_pb.ACT235INFO_MSG)
Activity235Module_pb.Act235TypeCount = protobuf.Message(Activity235Module_pb.ACT235TYPECOUNT_MSG)
Activity235Module_pb.ActivePreparationReply = protobuf.Message(Activity235Module_pb.ACTIVEPREPARATIONREPLY_MSG)
Activity235Module_pb.ActivePreparationRequest = protobuf.Message(Activity235Module_pb.ACTIVEPREPARATIONREQUEST_MSG)
Activity235Module_pb.FinishMiniGameReply = protobuf.Message(Activity235Module_pb.FINISHMINIGAMEREPLY_MSG)
Activity235Module_pb.FinishMiniGameRequest = protobuf.Message(Activity235Module_pb.FINISHMINIGAMEREQUEST_MSG)
Activity235Module_pb.GetAct235InfoReply = protobuf.Message(Activity235Module_pb.GETACT235INFOREPLY_MSG)
Activity235Module_pb.GetAct235InfoRequest = protobuf.Message(Activity235Module_pb.GETACT235INFOREQUEST_MSG)

return Activity235Module_pb
