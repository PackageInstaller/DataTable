-- chunkname: @modules/proto/FairylandModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.FairylandModule_pb", package.seeall)

local FairylandModule_pb = {}

FairylandModule_pb.RECORDDIALOGREQUEST_MSG = protobuf.Descriptor()
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG = protobuf.Descriptor()
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RECORDELEMENTREQUEST_MSG = protobuf.Descriptor()
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG = protobuf.Descriptor()
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG = protobuf.Descriptor()
FairylandModule_pb.FAIRYLANDINFO_MSG = protobuf.Descriptor()
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RECORDDIALOGREPLY_MSG = protobuf.Descriptor()
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG = protobuf.Descriptor()
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RECORDELEMENTREPLY_MSG = protobuf.Descriptor()
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD = protobuf.FieldDescriptor()
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.name = "dialogId"
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.full_name = ".RecordDialogRequest.dialogId"
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.number = 1
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.index = 0
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.label = 1
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.has_default_value = false
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.default_value = 0
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.type = 5
FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD.cpp_type = 1
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.name = "RecordDialogRequest"
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.full_name = ".RecordDialogRequest"
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.nested_types = {}
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.enum_types = {}
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.fields = {
	FairylandModule_pb.RECORDDIALOGREQUESTDIALOGIDFIELD
}
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.is_extendable = false
FairylandModule_pb.RECORDDIALOGREQUEST_MSG.extensions = {}
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.name = "info"
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.full_name = ".GetFairylandInfoReply.info"
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.number = 1
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.index = 0
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.label = 1
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.has_default_value = false
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.default_value = nil
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.message_type = FairylandModule_pb.FAIRYLANDINFO_MSG
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.type = 11
FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD.cpp_type = 10
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.name = "GetFairylandInfoReply"
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.full_name = ".GetFairylandInfoReply"
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.nested_types = {}
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.enum_types = {}
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.fields = {
	FairylandModule_pb.GETFAIRYLANDINFOREPLYINFOFIELD
}
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.is_extendable = false
FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG.extensions = {}
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.name = "elementId"
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.full_name = ".RecordElementRequest.elementId"
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.number = 1
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.index = 0
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.label = 1
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.has_default_value = false
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.default_value = 0
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.type = 5
FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD.cpp_type = 1
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.name = "RecordElementRequest"
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.full_name = ".RecordElementRequest"
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.nested_types = {}
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.enum_types = {}
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.fields = {
	FairylandModule_pb.RECORDELEMENTREQUESTELEMENTIDFIELD
}
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.is_extendable = false
FairylandModule_pb.RECORDELEMENTREQUEST_MSG.extensions = {}
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.name = "info"
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.full_name = ".ResolvePuzzleReply.info"
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.number = 1
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.index = 0
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.label = 1
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.has_default_value = false
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.default_value = nil
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.message_type = FairylandModule_pb.FAIRYLANDINFO_MSG
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.type = 11
FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD.cpp_type = 10
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.name = "ResolvePuzzleReply"
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.full_name = ".ResolvePuzzleReply"
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.nested_types = {}
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.enum_types = {}
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.fields = {
	FairylandModule_pb.RESOLVEPUZZLEREPLYINFOFIELD
}
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.is_extendable = false
FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG.extensions = {}
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.name = "GetFairylandInfoRequest"
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.full_name = ".GetFairylandInfoRequest"
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.nested_types = {}
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.enum_types = {}
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.fields = {}
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.is_extendable = false
FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG.extensions = {}
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.name = "passPuzzleId"
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.full_name = ".FairylandInfo.passPuzzleId"
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.number = 1
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.index = 0
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.label = 3
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.has_default_value = false
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.default_value = {}
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.type = 5
FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD.cpp_type = 1
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.name = "dialogId"
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.full_name = ".FairylandInfo.dialogId"
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.number = 2
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.index = 1
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.label = 3
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.has_default_value = false
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.default_value = {}
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.type = 5
FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD.cpp_type = 1
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.name = "finishElementId"
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.full_name = ".FairylandInfo.finishElementId"
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.number = 3
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.index = 2
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.label = 3
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.has_default_value = false
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.default_value = {}
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.type = 5
FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD.cpp_type = 1
FairylandModule_pb.FAIRYLANDINFO_MSG.name = "FairylandInfo"
FairylandModule_pb.FAIRYLANDINFO_MSG.full_name = ".FairylandInfo"
FairylandModule_pb.FAIRYLANDINFO_MSG.nested_types = {}
FairylandModule_pb.FAIRYLANDINFO_MSG.enum_types = {}
FairylandModule_pb.FAIRYLANDINFO_MSG.fields = {
	FairylandModule_pb.FAIRYLANDINFOPASSPUZZLEIDFIELD,
	FairylandModule_pb.FAIRYLANDINFODIALOGIDFIELD,
	FairylandModule_pb.FAIRYLANDINFOFINISHELEMENTIDFIELD
}
FairylandModule_pb.FAIRYLANDINFO_MSG.is_extendable = false
FairylandModule_pb.FAIRYLANDINFO_MSG.extensions = {}
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.name = "info"
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.full_name = ".RecordDialogReply.info"
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.number = 1
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.index = 0
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.label = 1
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.has_default_value = false
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.default_value = nil
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.message_type = FairylandModule_pb.FAIRYLANDINFO_MSG
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.type = 11
FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD.cpp_type = 10
FairylandModule_pb.RECORDDIALOGREPLY_MSG.name = "RecordDialogReply"
FairylandModule_pb.RECORDDIALOGREPLY_MSG.full_name = ".RecordDialogReply"
FairylandModule_pb.RECORDDIALOGREPLY_MSG.nested_types = {}
FairylandModule_pb.RECORDDIALOGREPLY_MSG.enum_types = {}
FairylandModule_pb.RECORDDIALOGREPLY_MSG.fields = {
	FairylandModule_pb.RECORDDIALOGREPLYINFOFIELD
}
FairylandModule_pb.RECORDDIALOGREPLY_MSG.is_extendable = false
FairylandModule_pb.RECORDDIALOGREPLY_MSG.extensions = {}
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.name = "passPuzzleId"
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.full_name = ".ResolvePuzzleRequest.passPuzzleId"
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.number = 1
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.index = 0
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.label = 1
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.has_default_value = false
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.default_value = 0
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.type = 5
FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD.cpp_type = 1
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.name = "answer"
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.full_name = ".ResolvePuzzleRequest.answer"
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.number = 2
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.index = 1
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.label = 1
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.has_default_value = false
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.default_value = ""
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.type = 9
FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD.cpp_type = 9
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.name = "ResolvePuzzleRequest"
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.full_name = ".ResolvePuzzleRequest"
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.nested_types = {}
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.enum_types = {}
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.fields = {
	FairylandModule_pb.RESOLVEPUZZLEREQUESTPASSPUZZLEIDFIELD,
	FairylandModule_pb.RESOLVEPUZZLEREQUESTANSWERFIELD
}
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.is_extendable = false
FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG.extensions = {}
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.name = "info"
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.full_name = ".RecordElementReply.info"
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.number = 1
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.index = 0
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.label = 1
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.has_default_value = false
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.default_value = nil
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.message_type = FairylandModule_pb.FAIRYLANDINFO_MSG
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.type = 11
FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD.cpp_type = 10
FairylandModule_pb.RECORDELEMENTREPLY_MSG.name = "RecordElementReply"
FairylandModule_pb.RECORDELEMENTREPLY_MSG.full_name = ".RecordElementReply"
FairylandModule_pb.RECORDELEMENTREPLY_MSG.nested_types = {}
FairylandModule_pb.RECORDELEMENTREPLY_MSG.enum_types = {}
FairylandModule_pb.RECORDELEMENTREPLY_MSG.fields = {
	FairylandModule_pb.RECORDELEMENTREPLYINFOFIELD
}
FairylandModule_pb.RECORDELEMENTREPLY_MSG.is_extendable = false
FairylandModule_pb.RECORDELEMENTREPLY_MSG.extensions = {}
FairylandModule_pb.FairylandInfo = protobuf.Message(FairylandModule_pb.FAIRYLANDINFO_MSG)
FairylandModule_pb.GetFairylandInfoReply = protobuf.Message(FairylandModule_pb.GETFAIRYLANDINFOREPLY_MSG)
FairylandModule_pb.GetFairylandInfoRequest = protobuf.Message(FairylandModule_pb.GETFAIRYLANDINFOREQUEST_MSG)
FairylandModule_pb.RecordDialogReply = protobuf.Message(FairylandModule_pb.RECORDDIALOGREPLY_MSG)
FairylandModule_pb.RecordDialogRequest = protobuf.Message(FairylandModule_pb.RECORDDIALOGREQUEST_MSG)
FairylandModule_pb.RecordElementReply = protobuf.Message(FairylandModule_pb.RECORDELEMENTREPLY_MSG)
FairylandModule_pb.RecordElementRequest = protobuf.Message(FairylandModule_pb.RECORDELEMENTREQUEST_MSG)
FairylandModule_pb.ResolvePuzzleReply = protobuf.Message(FairylandModule_pb.RESOLVEPUZZLEREPLY_MSG)
FairylandModule_pb.ResolvePuzzleRequest = protobuf.Message(FairylandModule_pb.RESOLVEPUZZLEREQUEST_MSG)

return FairylandModule_pb
