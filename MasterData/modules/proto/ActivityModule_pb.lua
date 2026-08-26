-- chunkname: @modules/proto/ActivityModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.ActivityModule_pb", package.seeall)

local ActivityModule_pb = {}

ActivityModule_pb.ACTIVITYINFO_MSG = protobuf.Descriptor()
ActivityModule_pb.ACTIVITYINFOIDFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOONLINEFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG = protobuf.Descriptor()
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG = protobuf.Descriptor()
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG = protobuf.Descriptor()
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG = protobuf.Descriptor()
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG = protobuf.Descriptor()
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ENDACTIVITYPUSH_MSG = protobuf.Descriptor()
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG = protobuf.Descriptor()
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG = protobuf.Descriptor()
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG = protobuf.Descriptor()
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG = protobuf.Descriptor()
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD = protobuf.FieldDescriptor()
ActivityModule_pb.ACTIVITYINFOIDFIELD.name = "id"
ActivityModule_pb.ACTIVITYINFOIDFIELD.full_name = ".ActivityInfo.id"
ActivityModule_pb.ACTIVITYINFOIDFIELD.number = 1
ActivityModule_pb.ACTIVITYINFOIDFIELD.index = 0
ActivityModule_pb.ACTIVITYINFOIDFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOIDFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOIDFIELD.default_value = 0
ActivityModule_pb.ACTIVITYINFOIDFIELD.type = 13
ActivityModule_pb.ACTIVITYINFOIDFIELD.cpp_type = 3
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.name = "startTime"
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.full_name = ".ActivityInfo.startTime"
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.number = 2
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.index = 1
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.default_value = 0
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.type = 4
ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD.cpp_type = 4
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.name = "endTime"
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.full_name = ".ActivityInfo.endTime"
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.number = 3
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.index = 2
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.default_value = 0
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.type = 4
ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD.cpp_type = 4
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.name = "online"
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.full_name = ".ActivityInfo.online"
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.number = 4
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.index = 3
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.default_value = false
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.type = 8
ActivityModule_pb.ACTIVITYINFOONLINEFIELD.cpp_type = 7
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.name = "isNewStage"
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.full_name = ".ActivityInfo.isNewStage"
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.number = 5
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.index = 4
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.default_value = false
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.type = 8
ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD.cpp_type = 7
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.name = "currentStage"
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.full_name = ".ActivityInfo.currentStage"
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.number = 6
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.index = 5
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.default_value = 0
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.type = 5
ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD.cpp_type = 1
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.name = "isUnlock"
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.full_name = ".ActivityInfo.isUnlock"
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.number = 7
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.index = 6
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.default_value = false
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.type = 8
ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD.cpp_type = 7
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.name = "isReceiveAllBonus"
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.full_name = ".ActivityInfo.isReceiveAllBonus"
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.number = 8
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.index = 7
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.label = 1
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.default_value = false
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.type = 8
ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD.cpp_type = 7
ActivityModule_pb.ACTIVITYINFO_MSG.name = "ActivityInfo"
ActivityModule_pb.ACTIVITYINFO_MSG.full_name = ".ActivityInfo"
ActivityModule_pb.ACTIVITYINFO_MSG.nested_types = {}
ActivityModule_pb.ACTIVITYINFO_MSG.enum_types = {}
ActivityModule_pb.ACTIVITYINFO_MSG.fields = {
	ActivityModule_pb.ACTIVITYINFOIDFIELD,
	ActivityModule_pb.ACTIVITYINFOSTARTTIMEFIELD,
	ActivityModule_pb.ACTIVITYINFOENDTIMEFIELD,
	ActivityModule_pb.ACTIVITYINFOONLINEFIELD,
	ActivityModule_pb.ACTIVITYINFOISNEWSTAGEFIELD,
	ActivityModule_pb.ACTIVITYINFOCURRENTSTAGEFIELD,
	ActivityModule_pb.ACTIVITYINFOISUNLOCKFIELD,
	ActivityModule_pb.ACTIVITYINFOISRECEIVEALLBONUSFIELD
}
ActivityModule_pb.ACTIVITYINFO_MSG.is_extendable = false
ActivityModule_pb.ACTIVITYINFO_MSG.extensions = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.name = "id"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.full_name = ".ActivityNewStageReadRequest.id"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.number = 1
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.index = 0
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.label = 3
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.default_value = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.type = 13
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.cpp_type = 3
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.name = "ActivityNewStageReadRequest"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.full_name = ".ActivityNewStageReadRequest"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.nested_types = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.enum_types = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.fields = {
	ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUESTIDFIELD
}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.is_extendable = false
ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG.extensions = {}
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.name = "id"
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.full_name = ".UnlockPermanentReply.id"
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.number = 1
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.index = 0
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.label = 1
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.has_default_value = false
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.default_value = 0
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.type = 13
ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD.cpp_type = 3
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.name = "UnlockPermanentReply"
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.full_name = ".UnlockPermanentReply"
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.nested_types = {}
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.enum_types = {}
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.fields = {
	ActivityModule_pb.UNLOCKPERMANENTREPLYIDFIELD
}
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.is_extendable = false
ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG.extensions = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.name = "id"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.full_name = ".ActivityNewStageReadReply.id"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.number = 1
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.index = 0
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.label = 3
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.has_default_value = false
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.default_value = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.type = 13
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD.cpp_type = 3
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.name = "ActivityNewStageReadReply"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.full_name = ".ActivityNewStageReadReply"
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.nested_types = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.enum_types = {}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.fields = {
	ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLYIDFIELD
}
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.is_extendable = false
ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG.extensions = {}
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.name = "GetActivityInfosRequest"
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.full_name = ".GetActivityInfosRequest"
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.nested_types = {}
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.enum_types = {}
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.fields = {}
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.is_extendable = false
ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG.extensions = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.name = "activityInfos"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.full_name = ".GetActivityInfosWithParamReply.activityInfos"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.number = 1
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.index = 0
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.label = 3
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.has_default_value = false
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.default_value = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.message_type = ActivityModule_pb.ACTIVITYINFO_MSG
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.type = 11
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.cpp_type = 10
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.name = "GetActivityInfosWithParamReply"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.full_name = ".GetActivityInfosWithParamReply"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.nested_types = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.enum_types = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.fields = {
	ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD
}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.is_extendable = false
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG.extensions = {}
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.name = "id"
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.full_name = ".EndActivityPush.id"
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.number = 1
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.index = 0
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.label = 1
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.has_default_value = false
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.default_value = 0
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.type = 13
ActivityModule_pb.ENDACTIVITYPUSHIDFIELD.cpp_type = 3
ActivityModule_pb.ENDACTIVITYPUSH_MSG.name = "EndActivityPush"
ActivityModule_pb.ENDACTIVITYPUSH_MSG.full_name = ".EndActivityPush"
ActivityModule_pb.ENDACTIVITYPUSH_MSG.nested_types = {}
ActivityModule_pb.ENDACTIVITYPUSH_MSG.enum_types = {}
ActivityModule_pb.ENDACTIVITYPUSH_MSG.fields = {
	ActivityModule_pb.ENDACTIVITYPUSHIDFIELD
}
ActivityModule_pb.ENDACTIVITYPUSH_MSG.is_extendable = false
ActivityModule_pb.ENDACTIVITYPUSH_MSG.extensions = {}
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.name = "activityInfos"
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.full_name = ".GetActivityInfosReply.activityInfos"
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.number = 1
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.index = 0
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.label = 3
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.has_default_value = false
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.default_value = {}
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.message_type = ActivityModule_pb.ACTIVITYINFO_MSG
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.type = 11
ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.cpp_type = 10
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.name = "GetActivityInfosReply"
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.full_name = ".GetActivityInfosReply"
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.nested_types = {}
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.enum_types = {}
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.fields = {
	ActivityModule_pb.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD
}
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.is_extendable = false
ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG.extensions = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.name = "activityIds"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.full_name = ".GetActivityInfosWithParamRequest.activityIds"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.number = 1
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.index = 0
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.label = 3
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.has_default_value = false
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.default_value = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.type = 5
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.cpp_type = 1
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.name = "GetActivityInfosWithParamRequest"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.full_name = ".GetActivityInfosWithParamRequest"
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.nested_types = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.enum_types = {}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.fields = {
	ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD
}
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.is_extendable = false
ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.extensions = {}
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.name = "activityInfo"
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.full_name = ".UpdateActivityPush.activityInfo"
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.number = 1
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.index = 0
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.label = 1
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.has_default_value = false
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.default_value = nil
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.message_type = ActivityModule_pb.ACTIVITYINFO_MSG
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.type = 11
ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.cpp_type = 10
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.name = "time"
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.full_name = ".UpdateActivityPush.time"
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.number = 2
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.index = 1
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.label = 1
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.has_default_value = false
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.default_value = 0
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.type = 5
ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD.cpp_type = 1
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.name = "UpdateActivityPush"
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.full_name = ".UpdateActivityPush"
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.nested_types = {}
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.enum_types = {}
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.fields = {
	ActivityModule_pb.UPDATEACTIVITYPUSHACTIVITYINFOFIELD,
	ActivityModule_pb.UPDATEACTIVITYPUSHTIMEFIELD
}
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.is_extendable = false
ActivityModule_pb.UPDATEACTIVITYPUSH_MSG.extensions = {}
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.name = "id"
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.full_name = ".UnlockPermanentRequest.id"
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.number = 1
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.index = 0
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.label = 1
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.has_default_value = false
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.default_value = 0
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.type = 13
ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD.cpp_type = 3
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.name = "UnlockPermanentRequest"
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.full_name = ".UnlockPermanentRequest"
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.nested_types = {}
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.enum_types = {}
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.fields = {
	ActivityModule_pb.UNLOCKPERMANENTREQUESTIDFIELD
}
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.is_extendable = false
ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG.extensions = {}
ActivityModule_pb.ActivityInfo = protobuf.Message(ActivityModule_pb.ACTIVITYINFO_MSG)
ActivityModule_pb.ActivityNewStageReadReply = protobuf.Message(ActivityModule_pb.ACTIVITYNEWSTAGEREADREPLY_MSG)
ActivityModule_pb.ActivityNewStageReadRequest = protobuf.Message(ActivityModule_pb.ACTIVITYNEWSTAGEREADREQUEST_MSG)
ActivityModule_pb.EndActivityPush = protobuf.Message(ActivityModule_pb.ENDACTIVITYPUSH_MSG)
ActivityModule_pb.GetActivityInfosReply = protobuf.Message(ActivityModule_pb.GETACTIVITYINFOSREPLY_MSG)
ActivityModule_pb.GetActivityInfosRequest = protobuf.Message(ActivityModule_pb.GETACTIVITYINFOSREQUEST_MSG)
ActivityModule_pb.GetActivityInfosWithParamReply = protobuf.Message(ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREPLY_MSG)
ActivityModule_pb.GetActivityInfosWithParamRequest = protobuf.Message(ActivityModule_pb.GETACTIVITYINFOSWITHPARAMREQUEST_MSG)
ActivityModule_pb.UnlockPermanentReply = protobuf.Message(ActivityModule_pb.UNLOCKPERMANENTREPLY_MSG)
ActivityModule_pb.UnlockPermanentRequest = protobuf.Message(ActivityModule_pb.UNLOCKPERMANENTREQUEST_MSG)
ActivityModule_pb.UpdateActivityPush = protobuf.Message(ActivityModule_pb.UPDATEACTIVITYPUSH_MSG)

return ActivityModule_pb
