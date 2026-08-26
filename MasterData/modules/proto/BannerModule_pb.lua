-- chunkname: @modules/proto/BannerModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.BannerModule_pb", package.seeall)

local BannerModule_pb = {}

BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG = protobuf.Descriptor()
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD = protobuf.FieldDescriptor()
BannerModule_pb.GETBANNERINFOREPLY_MSG = protobuf.Descriptor()
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD = protobuf.FieldDescriptor()
BannerModule_pb.GETBANNERINFOREQUEST_MSG = protobuf.Descriptor()
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG = protobuf.Descriptor()
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD = protobuf.FieldDescriptor()
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.name = "id"
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.full_name = ".SetBannerNotShowReply.id"
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.number = 1
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.index = 0
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.label = 1
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.has_default_value = false
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.default_value = 0
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.type = 5
BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD.cpp_type = 1
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.name = "SetBannerNotShowReply"
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.full_name = ".SetBannerNotShowReply"
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.nested_types = {}
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.enum_types = {}
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.fields = {
	BannerModule_pb.SETBANNERNOTSHOWREPLYIDFIELD
}
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.is_extendable = false
BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG.extensions = {}
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.name = "notShowIds"
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.full_name = ".GetBannerInfoReply.notShowIds"
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.number = 1
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.index = 0
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.label = 3
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.has_default_value = false
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.default_value = {}
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.type = 5
BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD.cpp_type = 1
BannerModule_pb.GETBANNERINFOREPLY_MSG.name = "GetBannerInfoReply"
BannerModule_pb.GETBANNERINFOREPLY_MSG.full_name = ".GetBannerInfoReply"
BannerModule_pb.GETBANNERINFOREPLY_MSG.nested_types = {}
BannerModule_pb.GETBANNERINFOREPLY_MSG.enum_types = {}
BannerModule_pb.GETBANNERINFOREPLY_MSG.fields = {
	BannerModule_pb.GETBANNERINFOREPLYNOTSHOWIDSFIELD
}
BannerModule_pb.GETBANNERINFOREPLY_MSG.is_extendable = false
BannerModule_pb.GETBANNERINFOREPLY_MSG.extensions = {}
BannerModule_pb.GETBANNERINFOREQUEST_MSG.name = "GetBannerInfoRequest"
BannerModule_pb.GETBANNERINFOREQUEST_MSG.full_name = ".GetBannerInfoRequest"
BannerModule_pb.GETBANNERINFOREQUEST_MSG.nested_types = {}
BannerModule_pb.GETBANNERINFOREQUEST_MSG.enum_types = {}
BannerModule_pb.GETBANNERINFOREQUEST_MSG.fields = {}
BannerModule_pb.GETBANNERINFOREQUEST_MSG.is_extendable = false
BannerModule_pb.GETBANNERINFOREQUEST_MSG.extensions = {}
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.name = "id"
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.full_name = ".SetBannerNotShowRequest.id"
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.number = 1
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.index = 0
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.label = 1
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.has_default_value = false
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.default_value = 0
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.type = 5
BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD.cpp_type = 1
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.name = "SetBannerNotShowRequest"
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.full_name = ".SetBannerNotShowRequest"
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.nested_types = {}
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.enum_types = {}
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.fields = {
	BannerModule_pb.SETBANNERNOTSHOWREQUESTIDFIELD
}
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.is_extendable = false
BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG.extensions = {}
BannerModule_pb.GetBannerInfoReply = protobuf.Message(BannerModule_pb.GETBANNERINFOREPLY_MSG)
BannerModule_pb.GetBannerInfoRequest = protobuf.Message(BannerModule_pb.GETBANNERINFOREQUEST_MSG)
BannerModule_pb.SetBannerNotShowReply = protobuf.Message(BannerModule_pb.SETBANNERNOTSHOWREPLY_MSG)
BannerModule_pb.SetBannerNotShowRequest = protobuf.Message(BannerModule_pb.SETBANNERNOTSHOWREQUEST_MSG)

return BannerModule_pb
