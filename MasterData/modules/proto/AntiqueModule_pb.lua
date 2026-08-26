-- chunkname: @modules/proto/AntiqueModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.AntiqueModule_pb", package.seeall)

local AntiqueModule_pb = {}

AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG = protobuf.Descriptor()
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG = protobuf.Descriptor()
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD = protobuf.FieldDescriptor()
AntiqueModule_pb.ANTIQUEINFO_MSG = protobuf.Descriptor()
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD = protobuf.FieldDescriptor()
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD = protobuf.FieldDescriptor()
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG = protobuf.Descriptor()
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD = protobuf.FieldDescriptor()
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.name = "GetAntiqueInfoRequest"
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.full_name = ".GetAntiqueInfoRequest"
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.nested_types = {}
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.enum_types = {}
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.fields = {}
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.is_extendable = false
AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG.extensions = {}
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.name = "antiques"
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.full_name = ".AntiqueUpdatePush.antiques"
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.number = 1
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.index = 0
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.label = 3
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.has_default_value = false
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.default_value = {}
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.message_type = AntiqueModule_pb.ANTIQUEINFO_MSG
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.type = 11
AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD.cpp_type = 10
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.name = "AntiqueUpdatePush"
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.full_name = ".AntiqueUpdatePush"
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.nested_types = {}
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.enum_types = {}
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.fields = {
	AntiqueModule_pb.ANTIQUEUPDATEPUSHANTIQUESFIELD
}
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.is_extendable = false
AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG.extensions = {}
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.name = "antiqueId"
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.full_name = ".AntiqueInfo.antiqueId"
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.number = 1
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.index = 0
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.label = 1
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.has_default_value = false
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.default_value = 0
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.type = 5
AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD.cpp_type = 1
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.name = "getTime"
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.full_name = ".AntiqueInfo.getTime"
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.number = 2
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.index = 1
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.label = 1
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.has_default_value = false
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.default_value = 0
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.type = 4
AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD.cpp_type = 4
AntiqueModule_pb.ANTIQUEINFO_MSG.name = "AntiqueInfo"
AntiqueModule_pb.ANTIQUEINFO_MSG.full_name = ".AntiqueInfo"
AntiqueModule_pb.ANTIQUEINFO_MSG.nested_types = {}
AntiqueModule_pb.ANTIQUEINFO_MSG.enum_types = {}
AntiqueModule_pb.ANTIQUEINFO_MSG.fields = {
	AntiqueModule_pb.ANTIQUEINFOANTIQUEIDFIELD,
	AntiqueModule_pb.ANTIQUEINFOGETTIMEFIELD
}
AntiqueModule_pb.ANTIQUEINFO_MSG.is_extendable = false
AntiqueModule_pb.ANTIQUEINFO_MSG.extensions = {}
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.name = "antiques"
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.full_name = ".GetAntiqueInfoReply.antiques"
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.number = 1
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.index = 0
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.label = 3
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.has_default_value = false
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.default_value = {}
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.message_type = AntiqueModule_pb.ANTIQUEINFO_MSG
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.type = 11
AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD.cpp_type = 10
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.name = "GetAntiqueInfoReply"
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.full_name = ".GetAntiqueInfoReply"
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.nested_types = {}
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.enum_types = {}
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.fields = {
	AntiqueModule_pb.GETANTIQUEINFOREPLYANTIQUESFIELD
}
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.is_extendable = false
AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG.extensions = {}
AntiqueModule_pb.AntiqueInfo = protobuf.Message(AntiqueModule_pb.ANTIQUEINFO_MSG)
AntiqueModule_pb.AntiqueUpdatePush = protobuf.Message(AntiqueModule_pb.ANTIQUEUPDATEPUSH_MSG)
AntiqueModule_pb.GetAntiqueInfoReply = protobuf.Message(AntiqueModule_pb.GETANTIQUEINFOREPLY_MSG)
AntiqueModule_pb.GetAntiqueInfoRequest = protobuf.Message(AntiqueModule_pb.GETANTIQUEINFOREQUEST_MSG)

return AntiqueModule_pb
