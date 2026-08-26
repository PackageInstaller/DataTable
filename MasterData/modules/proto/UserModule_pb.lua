-- chunkname: @modules/proto/UserModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.UserModule_pb", package.seeall)

local UserModule_pb = {}

UserModule_pb.LOGOUTREQUEST_MSG = protobuf.Descriptor()
UserModule_pb.DEBUGLOGOUTREQUEST_MSG = protobuf.Descriptor()
UserModule_pb.DEBUGLOGOUTREPLY_MSG = protobuf.Descriptor()
UserModule_pb.LOGOUTREPLY_MSG = protobuf.Descriptor()
UserModule_pb.LOGOUTREQUEST_MSG.name = "LogoutRequest"
UserModule_pb.LOGOUTREQUEST_MSG.full_name = ".LogoutRequest"
UserModule_pb.LOGOUTREQUEST_MSG.nested_types = {}
UserModule_pb.LOGOUTREQUEST_MSG.enum_types = {}
UserModule_pb.LOGOUTREQUEST_MSG.fields = {}
UserModule_pb.LOGOUTREQUEST_MSG.is_extendable = false
UserModule_pb.LOGOUTREQUEST_MSG.extensions = {}
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.name = "DebugLogoutRequest"
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.full_name = ".DebugLogoutRequest"
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.nested_types = {}
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.enum_types = {}
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.fields = {}
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.is_extendable = false
UserModule_pb.DEBUGLOGOUTREQUEST_MSG.extensions = {}
UserModule_pb.DEBUGLOGOUTREPLY_MSG.name = "DebugLogoutReply"
UserModule_pb.DEBUGLOGOUTREPLY_MSG.full_name = ".DebugLogoutReply"
UserModule_pb.DEBUGLOGOUTREPLY_MSG.nested_types = {}
UserModule_pb.DEBUGLOGOUTREPLY_MSG.enum_types = {}
UserModule_pb.DEBUGLOGOUTREPLY_MSG.fields = {}
UserModule_pb.DEBUGLOGOUTREPLY_MSG.is_extendable = false
UserModule_pb.DEBUGLOGOUTREPLY_MSG.extensions = {}
UserModule_pb.LOGOUTREPLY_MSG.name = "LogoutReply"
UserModule_pb.LOGOUTREPLY_MSG.full_name = ".LogoutReply"
UserModule_pb.LOGOUTREPLY_MSG.nested_types = {}
UserModule_pb.LOGOUTREPLY_MSG.enum_types = {}
UserModule_pb.LOGOUTREPLY_MSG.fields = {}
UserModule_pb.LOGOUTREPLY_MSG.is_extendable = false
UserModule_pb.LOGOUTREPLY_MSG.extensions = {}
UserModule_pb.DebugLogoutReply = protobuf.Message(UserModule_pb.DEBUGLOGOUTREPLY_MSG)
UserModule_pb.DebugLogoutRequest = protobuf.Message(UserModule_pb.DEBUGLOGOUTREQUEST_MSG)
UserModule_pb.LogoutReply = protobuf.Message(UserModule_pb.LOGOUTREPLY_MSG)
UserModule_pb.LogoutRequest = protobuf.Message(UserModule_pb.LOGOUTREQUEST_MSG)

return UserModule_pb
