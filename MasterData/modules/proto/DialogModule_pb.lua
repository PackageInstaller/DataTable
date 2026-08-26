-- chunkname: @modules/proto/DialogModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.DialogModule_pb", package.seeall)

local DialogModule_pb = {}

DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG = protobuf.Descriptor()
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD = protobuf.FieldDescriptor()
DialogModule_pb.GETDIALOGINFOREQUEST_MSG = protobuf.Descriptor()
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG = protobuf.Descriptor()
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD = protobuf.FieldDescriptor()
DialogModule_pb.GETDIALOGINFOREPLY_MSG = protobuf.Descriptor()
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD = protobuf.FieldDescriptor()
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.name = "dialogId"
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.full_name = ".RecordDialogInfoRequest.dialogId"
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.number = 1
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.index = 0
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.label = 1
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.has_default_value = false
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.default_value = 0
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.type = 5
DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD.cpp_type = 1
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.name = "RecordDialogInfoRequest"
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.full_name = ".RecordDialogInfoRequest"
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.nested_types = {}
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.enum_types = {}
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.fields = {
	DialogModule_pb.RECORDDIALOGINFOREQUESTDIALOGIDFIELD
}
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.is_extendable = false
DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG.extensions = {}
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.name = "GetDialogInfoRequest"
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.full_name = ".GetDialogInfoRequest"
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.nested_types = {}
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.enum_types = {}
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.fields = {}
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.is_extendable = false
DialogModule_pb.GETDIALOGINFOREQUEST_MSG.extensions = {}
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.name = "dialogId"
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.full_name = ".RecordDialogInfoReplay.dialogId"
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.number = 1
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.index = 0
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.label = 1
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.has_default_value = false
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.default_value = 0
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.type = 5
DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD.cpp_type = 1
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.name = "RecordDialogInfoReplay"
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.full_name = ".RecordDialogInfoReplay"
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.nested_types = {}
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.enum_types = {}
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.fields = {
	DialogModule_pb.RECORDDIALOGINFOREPLAYDIALOGIDFIELD
}
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.is_extendable = false
DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG.extensions = {}
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.name = "dialogIds"
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.full_name = ".GetDialogInfoReply.dialogIds"
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.number = 1
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.index = 0
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.label = 3
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.has_default_value = false
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.default_value = {}
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.type = 5
DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD.cpp_type = 1
DialogModule_pb.GETDIALOGINFOREPLY_MSG.name = "GetDialogInfoReply"
DialogModule_pb.GETDIALOGINFOREPLY_MSG.full_name = ".GetDialogInfoReply"
DialogModule_pb.GETDIALOGINFOREPLY_MSG.nested_types = {}
DialogModule_pb.GETDIALOGINFOREPLY_MSG.enum_types = {}
DialogModule_pb.GETDIALOGINFOREPLY_MSG.fields = {
	DialogModule_pb.GETDIALOGINFOREPLYDIALOGIDSFIELD
}
DialogModule_pb.GETDIALOGINFOREPLY_MSG.is_extendable = false
DialogModule_pb.GETDIALOGINFOREPLY_MSG.extensions = {}
DialogModule_pb.GetDialogInfoReply = protobuf.Message(DialogModule_pb.GETDIALOGINFOREPLY_MSG)
DialogModule_pb.GetDialogInfoRequest = protobuf.Message(DialogModule_pb.GETDIALOGINFOREQUEST_MSG)
DialogModule_pb.RecordDialogInfoReplay = protobuf.Message(DialogModule_pb.RECORDDIALOGINFOREPLAY_MSG)
DialogModule_pb.RecordDialogInfoRequest = protobuf.Message(DialogModule_pb.RECORDDIALOGINFOREQUEST_MSG)

return DialogModule_pb
