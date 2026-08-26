-- chunkname: @modules/proto/Activity238Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity238Module_pb", package.seeall)

local Activity238Module_pb = {}

Activity238Module_pb.GETACT238INFOREQUEST_MSG = protobuf.Descriptor()
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238BONUSREQUEST_MSG = protobuf.Descriptor()
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238SIGNNO_MSG = protobuf.Descriptor()
Activity238Module_pb.ACT238SIGNNOIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238ANSWERREQUEST_MSG = protobuf.Descriptor()
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238BONUSREPLY_MSG = protobuf.Descriptor()
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.GETACT238INFOREPLY_MSG = protobuf.Descriptor()
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238ANSWERREPLY_MSG = protobuf.Descriptor()
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD = protobuf.FieldDescriptor()
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct238InfoRequest.activityId"
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.number = 1
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.index = 0
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.label = 1
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.type = 5
Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity238Module_pb.GETACT238INFOREQUEST_MSG.name = "GetAct238InfoRequest"
Activity238Module_pb.GETACT238INFOREQUEST_MSG.full_name = ".GetAct238InfoRequest"
Activity238Module_pb.GETACT238INFOREQUEST_MSG.nested_types = {}
Activity238Module_pb.GETACT238INFOREQUEST_MSG.enum_types = {}
Activity238Module_pb.GETACT238INFOREQUEST_MSG.fields = {
	Activity238Module_pb.GETACT238INFOREQUESTACTIVITYIDFIELD
}
Activity238Module_pb.GETACT238INFOREQUEST_MSG.is_extendable = false
Activity238Module_pb.GETACT238INFOREQUEST_MSG.extensions = {}
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.full_name = ".Act238BonusRequest.activityId"
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.number = 1
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.index = 0
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.label = 1
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.type = 5
Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.name = "id"
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.full_name = ".Act238BonusRequest.id"
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.number = 2
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.index = 1
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.label = 1
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.has_default_value = false
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.default_value = 0
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.type = 5
Activity238Module_pb.ACT238BONUSREQUESTIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238BONUSREQUEST_MSG.name = "Act238BonusRequest"
Activity238Module_pb.ACT238BONUSREQUEST_MSG.full_name = ".Act238BonusRequest"
Activity238Module_pb.ACT238BONUSREQUEST_MSG.nested_types = {}
Activity238Module_pb.ACT238BONUSREQUEST_MSG.enum_types = {}
Activity238Module_pb.ACT238BONUSREQUEST_MSG.fields = {
	Activity238Module_pb.ACT238BONUSREQUESTACTIVITYIDFIELD,
	Activity238Module_pb.ACT238BONUSREQUESTIDFIELD
}
Activity238Module_pb.ACT238BONUSREQUEST_MSG.is_extendable = false
Activity238Module_pb.ACT238BONUSREQUEST_MSG.extensions = {}
Activity238Module_pb.ACT238SIGNNOIDFIELD.name = "id"
Activity238Module_pb.ACT238SIGNNOIDFIELD.full_name = ".Act238SignNO.id"
Activity238Module_pb.ACT238SIGNNOIDFIELD.number = 1
Activity238Module_pb.ACT238SIGNNOIDFIELD.index = 0
Activity238Module_pb.ACT238SIGNNOIDFIELD.label = 1
Activity238Module_pb.ACT238SIGNNOIDFIELD.has_default_value = false
Activity238Module_pb.ACT238SIGNNOIDFIELD.default_value = 0
Activity238Module_pb.ACT238SIGNNOIDFIELD.type = 5
Activity238Module_pb.ACT238SIGNNOIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.name = "status"
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.full_name = ".Act238SignNO.status"
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.number = 2
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.index = 1
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.label = 1
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.has_default_value = false
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.default_value = 0
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.type = 5
Activity238Module_pb.ACT238SIGNNOSTATUSFIELD.cpp_type = 1
Activity238Module_pb.ACT238SIGNNO_MSG.name = "Act238SignNO"
Activity238Module_pb.ACT238SIGNNO_MSG.full_name = ".Act238SignNO"
Activity238Module_pb.ACT238SIGNNO_MSG.nested_types = {}
Activity238Module_pb.ACT238SIGNNO_MSG.enum_types = {}
Activity238Module_pb.ACT238SIGNNO_MSG.fields = {
	Activity238Module_pb.ACT238SIGNNOIDFIELD,
	Activity238Module_pb.ACT238SIGNNOSTATUSFIELD
}
Activity238Module_pb.ACT238SIGNNO_MSG.is_extendable = false
Activity238Module_pb.ACT238SIGNNO_MSG.extensions = {}
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.name = "activityId"
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.full_name = ".Act238AnswerRequest.activityId"
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.number = 1
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.index = 0
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.label = 1
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.has_default_value = false
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.default_value = 0
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.type = 5
Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.name = "id"
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.full_name = ".Act238AnswerRequest.id"
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.number = 2
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.index = 1
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.label = 1
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.has_default_value = false
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.default_value = 0
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.type = 5
Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.name = "Act238AnswerRequest"
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.full_name = ".Act238AnswerRequest"
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.nested_types = {}
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.enum_types = {}
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.fields = {
	Activity238Module_pb.ACT238ANSWERREQUESTACTIVITYIDFIELD,
	Activity238Module_pb.ACT238ANSWERREQUESTIDFIELD
}
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.is_extendable = false
Activity238Module_pb.ACT238ANSWERREQUEST_MSG.extensions = {}
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.full_name = ".Act238BonusReply.activityId"
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.number = 1
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.index = 0
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.label = 1
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.type = 5
Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.name = "sign"
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.full_name = ".Act238BonusReply.sign"
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.number = 2
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.index = 1
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.label = 1
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.has_default_value = false
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.default_value = nil
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.message_type = Activity238Module_pb.ACT238SIGNNO_MSG
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.type = 11
Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD.cpp_type = 10
Activity238Module_pb.ACT238BONUSREPLY_MSG.name = "Act238BonusReply"
Activity238Module_pb.ACT238BONUSREPLY_MSG.full_name = ".Act238BonusReply"
Activity238Module_pb.ACT238BONUSREPLY_MSG.nested_types = {}
Activity238Module_pb.ACT238BONUSREPLY_MSG.enum_types = {}
Activity238Module_pb.ACT238BONUSREPLY_MSG.fields = {
	Activity238Module_pb.ACT238BONUSREPLYACTIVITYIDFIELD,
	Activity238Module_pb.ACT238BONUSREPLYSIGNFIELD
}
Activity238Module_pb.ACT238BONUSREPLY_MSG.is_extendable = false
Activity238Module_pb.ACT238BONUSREPLY_MSG.extensions = {}
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct238InfoReply.activityId"
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.number = 1
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.index = 0
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.label = 1
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.type = 5
Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.name = "signs"
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.full_name = ".GetAct238InfoReply.signs"
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.number = 2
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.index = 1
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.label = 3
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.has_default_value = false
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.default_value = {}
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.message_type = Activity238Module_pb.ACT238SIGNNO_MSG
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.type = 11
Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD.cpp_type = 10
Activity238Module_pb.GETACT238INFOREPLY_MSG.name = "GetAct238InfoReply"
Activity238Module_pb.GETACT238INFOREPLY_MSG.full_name = ".GetAct238InfoReply"
Activity238Module_pb.GETACT238INFOREPLY_MSG.nested_types = {}
Activity238Module_pb.GETACT238INFOREPLY_MSG.enum_types = {}
Activity238Module_pb.GETACT238INFOREPLY_MSG.fields = {
	Activity238Module_pb.GETACT238INFOREPLYACTIVITYIDFIELD,
	Activity238Module_pb.GETACT238INFOREPLYSIGNSFIELD
}
Activity238Module_pb.GETACT238INFOREPLY_MSG.is_extendable = false
Activity238Module_pb.GETACT238INFOREPLY_MSG.extensions = {}
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.name = "activityId"
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.full_name = ".Act238AnswerReply.activityId"
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.number = 1
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.index = 0
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.label = 1
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.has_default_value = false
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.default_value = 0
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.type = 5
Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD.cpp_type = 1
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.name = "sign"
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.full_name = ".Act238AnswerReply.sign"
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.number = 2
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.index = 1
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.label = 1
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.has_default_value = false
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.default_value = nil
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.message_type = Activity238Module_pb.ACT238SIGNNO_MSG
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.type = 11
Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD.cpp_type = 10
Activity238Module_pb.ACT238ANSWERREPLY_MSG.name = "Act238AnswerReply"
Activity238Module_pb.ACT238ANSWERREPLY_MSG.full_name = ".Act238AnswerReply"
Activity238Module_pb.ACT238ANSWERREPLY_MSG.nested_types = {}
Activity238Module_pb.ACT238ANSWERREPLY_MSG.enum_types = {}
Activity238Module_pb.ACT238ANSWERREPLY_MSG.fields = {
	Activity238Module_pb.ACT238ANSWERREPLYACTIVITYIDFIELD,
	Activity238Module_pb.ACT238ANSWERREPLYSIGNFIELD
}
Activity238Module_pb.ACT238ANSWERREPLY_MSG.is_extendable = false
Activity238Module_pb.ACT238ANSWERREPLY_MSG.extensions = {}
Activity238Module_pb.Act238AnswerReply = protobuf.Message(Activity238Module_pb.ACT238ANSWERREPLY_MSG)
Activity238Module_pb.Act238AnswerRequest = protobuf.Message(Activity238Module_pb.ACT238ANSWERREQUEST_MSG)
Activity238Module_pb.Act238BonusReply = protobuf.Message(Activity238Module_pb.ACT238BONUSREPLY_MSG)
Activity238Module_pb.Act238BonusRequest = protobuf.Message(Activity238Module_pb.ACT238BONUSREQUEST_MSG)
Activity238Module_pb.Act238SignNO = protobuf.Message(Activity238Module_pb.ACT238SIGNNO_MSG)
Activity238Module_pb.GetAct238InfoReply = protobuf.Message(Activity238Module_pb.GETACT238INFOREPLY_MSG)
Activity238Module_pb.GetAct238InfoRequest = protobuf.Message(Activity238Module_pb.GETACT238INFOREQUEST_MSG)

return Activity238Module_pb
