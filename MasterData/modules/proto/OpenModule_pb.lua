-- chunkname: @modules/proto/OpenModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.OpenModule_pb", package.seeall)

local OpenModule_pb = {}

OpenModule_pb.OPENINFO_MSG = protobuf.Descriptor()
OpenModule_pb.OPENINFOIDFIELD = protobuf.FieldDescriptor()
OpenModule_pb.OPENINFOISOPENFIELD = protobuf.FieldDescriptor()
OpenModule_pb.GETOPENINFOREQUEST_MSG = protobuf.Descriptor()
OpenModule_pb.GETOPENINFOREQUESTIDFIELD = protobuf.FieldDescriptor()
OpenModule_pb.UPDATEOPENPUSH_MSG = protobuf.Descriptor()
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD = protobuf.FieldDescriptor()
OpenModule_pb.GETOPENINFOREPLY_MSG = protobuf.Descriptor()
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD = protobuf.FieldDescriptor()
OpenModule_pb.OPENINFOIDFIELD.name = "id"
OpenModule_pb.OPENINFOIDFIELD.full_name = ".OpenInfo.id"
OpenModule_pb.OPENINFOIDFIELD.number = 1
OpenModule_pb.OPENINFOIDFIELD.index = 0
OpenModule_pb.OPENINFOIDFIELD.label = 2
OpenModule_pb.OPENINFOIDFIELD.has_default_value = false
OpenModule_pb.OPENINFOIDFIELD.default_value = 0
OpenModule_pb.OPENINFOIDFIELD.type = 5
OpenModule_pb.OPENINFOIDFIELD.cpp_type = 1
OpenModule_pb.OPENINFOISOPENFIELD.name = "isOpen"
OpenModule_pb.OPENINFOISOPENFIELD.full_name = ".OpenInfo.isOpen"
OpenModule_pb.OPENINFOISOPENFIELD.number = 2
OpenModule_pb.OPENINFOISOPENFIELD.index = 1
OpenModule_pb.OPENINFOISOPENFIELD.label = 2
OpenModule_pb.OPENINFOISOPENFIELD.has_default_value = false
OpenModule_pb.OPENINFOISOPENFIELD.default_value = false
OpenModule_pb.OPENINFOISOPENFIELD.type = 8
OpenModule_pb.OPENINFOISOPENFIELD.cpp_type = 7
OpenModule_pb.OPENINFO_MSG.name = "OpenInfo"
OpenModule_pb.OPENINFO_MSG.full_name = ".OpenInfo"
OpenModule_pb.OPENINFO_MSG.nested_types = {}
OpenModule_pb.OPENINFO_MSG.enum_types = {}
OpenModule_pb.OPENINFO_MSG.fields = {
	OpenModule_pb.OPENINFOIDFIELD,
	OpenModule_pb.OPENINFOISOPENFIELD
}
OpenModule_pb.OPENINFO_MSG.is_extendable = false
OpenModule_pb.OPENINFO_MSG.extensions = {}
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.name = "id"
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.full_name = ".GetOpenInfoRequest.id"
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.number = 1
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.index = 0
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.label = 2
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.has_default_value = false
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.default_value = 0
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.type = 5
OpenModule_pb.GETOPENINFOREQUESTIDFIELD.cpp_type = 1
OpenModule_pb.GETOPENINFOREQUEST_MSG.name = "GetOpenInfoRequest"
OpenModule_pb.GETOPENINFOREQUEST_MSG.full_name = ".GetOpenInfoRequest"
OpenModule_pb.GETOPENINFOREQUEST_MSG.nested_types = {}
OpenModule_pb.GETOPENINFOREQUEST_MSG.enum_types = {}
OpenModule_pb.GETOPENINFOREQUEST_MSG.fields = {
	OpenModule_pb.GETOPENINFOREQUESTIDFIELD
}
OpenModule_pb.GETOPENINFOREQUEST_MSG.is_extendable = false
OpenModule_pb.GETOPENINFOREQUEST_MSG.extensions = {}
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.name = "openInfos"
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.full_name = ".UpdateOpenPush.openInfos"
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.number = 1
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.index = 0
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.label = 3
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.has_default_value = false
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.default_value = {}
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.message_type = OpenModule_pb.OPENINFO_MSG
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.type = 11
OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD.cpp_type = 10
OpenModule_pb.UPDATEOPENPUSH_MSG.name = "UpdateOpenPush"
OpenModule_pb.UPDATEOPENPUSH_MSG.full_name = ".UpdateOpenPush"
OpenModule_pb.UPDATEOPENPUSH_MSG.nested_types = {}
OpenModule_pb.UPDATEOPENPUSH_MSG.enum_types = {}
OpenModule_pb.UPDATEOPENPUSH_MSG.fields = {
	OpenModule_pb.UPDATEOPENPUSHOPENINFOSFIELD
}
OpenModule_pb.UPDATEOPENPUSH_MSG.is_extendable = false
OpenModule_pb.UPDATEOPENPUSH_MSG.extensions = {}
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.name = "openIfo"
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.full_name = ".GetOpenInfoReply.openIfo"
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.number = 1
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.index = 0
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.label = 2
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.has_default_value = false
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.default_value = nil
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.message_type = OpenModule_pb.OPENINFO_MSG
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.type = 11
OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD.cpp_type = 10
OpenModule_pb.GETOPENINFOREPLY_MSG.name = "GetOpenInfoReply"
OpenModule_pb.GETOPENINFOREPLY_MSG.full_name = ".GetOpenInfoReply"
OpenModule_pb.GETOPENINFOREPLY_MSG.nested_types = {}
OpenModule_pb.GETOPENINFOREPLY_MSG.enum_types = {}
OpenModule_pb.GETOPENINFOREPLY_MSG.fields = {
	OpenModule_pb.GETOPENINFOREPLYOPENIFOFIELD
}
OpenModule_pb.GETOPENINFOREPLY_MSG.is_extendable = false
OpenModule_pb.GETOPENINFOREPLY_MSG.extensions = {}
OpenModule_pb.GetOpenInfoReply = protobuf.Message(OpenModule_pb.GETOPENINFOREPLY_MSG)
OpenModule_pb.GetOpenInfoRequest = protobuf.Message(OpenModule_pb.GETOPENINFOREQUEST_MSG)
OpenModule_pb.OpenInfo = protobuf.Message(OpenModule_pb.OPENINFO_MSG)
OpenModule_pb.UpdateOpenPush = protobuf.Message(OpenModule_pb.UPDATEOPENPUSH_MSG)

return OpenModule_pb
