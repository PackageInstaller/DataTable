-- chunkname: @modules/proto/CommonModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.CommonModule_pb", package.seeall)

local CommonModule_pb = {}

CommonModule_pb.GETSERVERTIMEREPLY_MSG = protobuf.Descriptor()
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD = protobuf.FieldDescriptor()
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD = protobuf.FieldDescriptor()
CommonModule_pb.GETSERVERTIMEREQUEST_MSG = protobuf.Descriptor()
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.name = "serverTime"
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.full_name = ".GetServerTimeReply.serverTime"
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.number = 1
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.index = 0
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.label = 1
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.has_default_value = false
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.default_value = 0
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.type = 4
CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD.cpp_type = 4
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.name = "offsetTime"
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.full_name = ".GetServerTimeReply.offsetTime"
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.number = 2
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.index = 1
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.label = 1
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.has_default_value = false
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.default_value = 0
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.type = 3
CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD.cpp_type = 2
CommonModule_pb.GETSERVERTIMEREPLY_MSG.name = "GetServerTimeReply"
CommonModule_pb.GETSERVERTIMEREPLY_MSG.full_name = ".GetServerTimeReply"
CommonModule_pb.GETSERVERTIMEREPLY_MSG.nested_types = {}
CommonModule_pb.GETSERVERTIMEREPLY_MSG.enum_types = {}
CommonModule_pb.GETSERVERTIMEREPLY_MSG.fields = {
	CommonModule_pb.GETSERVERTIMEREPLYSERVERTIMEFIELD,
	CommonModule_pb.GETSERVERTIMEREPLYOFFSETTIMEFIELD
}
CommonModule_pb.GETSERVERTIMEREPLY_MSG.is_extendable = false
CommonModule_pb.GETSERVERTIMEREPLY_MSG.extensions = {}
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.name = "GetServerTimeRequest"
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.full_name = ".GetServerTimeRequest"
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.nested_types = {}
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.enum_types = {}
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.fields = {}
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.is_extendable = false
CommonModule_pb.GETSERVERTIMEREQUEST_MSG.extensions = {}
CommonModule_pb.GetServerTimeReply = protobuf.Message(CommonModule_pb.GETSERVERTIMEREPLY_MSG)
CommonModule_pb.GetServerTimeRequest = protobuf.Message(CommonModule_pb.GETSERVERTIMEREQUEST_MSG)

return CommonModule_pb
