-- chunkname: @modules/proto/Activity201Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity201Module_pb", package.seeall)

local Activity201Module_pb = {}

Activity201Module_pb.GET201INFOREQUEST_MSG = protobuf.Descriptor()
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.INVITEPLAYER_MSG = protobuf.Descriptor()
Activity201Module_pb.INVITEPLAYERUSERIDFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.INVITEPLAYERNAMEFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.GET201INFOREPLY_MSG = protobuf.Descriptor()
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD = protobuf.FieldDescriptor()
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.full_name = ".Get201InfoRequest.activityId"
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.number = 1
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.index = 0
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.label = 1
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.type = 5
Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity201Module_pb.GET201INFOREQUEST_MSG.name = "Get201InfoRequest"
Activity201Module_pb.GET201INFOREQUEST_MSG.full_name = ".Get201InfoRequest"
Activity201Module_pb.GET201INFOREQUEST_MSG.nested_types = {}
Activity201Module_pb.GET201INFOREQUEST_MSG.enum_types = {}
Activity201Module_pb.GET201INFOREQUEST_MSG.fields = {
	Activity201Module_pb.GET201INFOREQUESTACTIVITYIDFIELD
}
Activity201Module_pb.GET201INFOREQUEST_MSG.is_extendable = false
Activity201Module_pb.GET201INFOREQUEST_MSG.extensions = {}
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.name = "userId"
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.full_name = ".InvitePlayer.userId"
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.number = 1
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.index = 0
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.label = 1
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.has_default_value = false
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.default_value = 0
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.type = 3
Activity201Module_pb.INVITEPLAYERUSERIDFIELD.cpp_type = 2
Activity201Module_pb.INVITEPLAYERNAMEFIELD.name = "name"
Activity201Module_pb.INVITEPLAYERNAMEFIELD.full_name = ".InvitePlayer.name"
Activity201Module_pb.INVITEPLAYERNAMEFIELD.number = 2
Activity201Module_pb.INVITEPLAYERNAMEFIELD.index = 1
Activity201Module_pb.INVITEPLAYERNAMEFIELD.label = 1
Activity201Module_pb.INVITEPLAYERNAMEFIELD.has_default_value = false
Activity201Module_pb.INVITEPLAYERNAMEFIELD.default_value = ""
Activity201Module_pb.INVITEPLAYERNAMEFIELD.type = 9
Activity201Module_pb.INVITEPLAYERNAMEFIELD.cpp_type = 9
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.name = "portrait"
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.full_name = ".InvitePlayer.portrait"
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.number = 3
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.index = 2
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.label = 1
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.has_default_value = false
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.default_value = 0
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.type = 5
Activity201Module_pb.INVITEPLAYERPORTRAITFIELD.cpp_type = 1
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.name = "roleType"
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.full_name = ".InvitePlayer.roleType"
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.number = 4
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.index = 3
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.label = 1
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.has_default_value = false
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.default_value = 0
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.type = 5
Activity201Module_pb.INVITEPLAYERROLETYPEFIELD.cpp_type = 1
Activity201Module_pb.INVITEPLAYER_MSG.name = "InvitePlayer"
Activity201Module_pb.INVITEPLAYER_MSG.full_name = ".InvitePlayer"
Activity201Module_pb.INVITEPLAYER_MSG.nested_types = {}
Activity201Module_pb.INVITEPLAYER_MSG.enum_types = {}
Activity201Module_pb.INVITEPLAYER_MSG.fields = {
	Activity201Module_pb.INVITEPLAYERUSERIDFIELD,
	Activity201Module_pb.INVITEPLAYERNAMEFIELD,
	Activity201Module_pb.INVITEPLAYERPORTRAITFIELD,
	Activity201Module_pb.INVITEPLAYERROLETYPEFIELD
}
Activity201Module_pb.INVITEPLAYER_MSG.is_extendable = false
Activity201Module_pb.INVITEPLAYER_MSG.extensions = {}
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.full_name = ".Get201InfoReply.activityId"
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.number = 1
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.index = 0
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.label = 1
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.type = 5
Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.name = "isTurnback"
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.full_name = ".Get201InfoReply.isTurnback"
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.number = 2
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.index = 1
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.label = 1
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.has_default_value = false
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.default_value = false
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.type = 8
Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD.cpp_type = 7
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.name = "invitePlayers"
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.full_name = ".Get201InfoReply.invitePlayers"
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.number = 3
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.index = 2
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.label = 3
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.has_default_value = false
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.default_value = {}
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.message_type = Activity201Module_pb.INVITEPLAYER_MSG
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.type = 11
Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD.cpp_type = 10
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.name = "inviteCode"
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.full_name = ".Get201InfoReply.inviteCode"
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.number = 4
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.index = 3
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.label = 1
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.has_default_value = false
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.default_value = ""
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.type = 9
Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD.cpp_type = 9
Activity201Module_pb.GET201INFOREPLY_MSG.name = "Get201InfoReply"
Activity201Module_pb.GET201INFOREPLY_MSG.full_name = ".Get201InfoReply"
Activity201Module_pb.GET201INFOREPLY_MSG.nested_types = {}
Activity201Module_pb.GET201INFOREPLY_MSG.enum_types = {}
Activity201Module_pb.GET201INFOREPLY_MSG.fields = {
	Activity201Module_pb.GET201INFOREPLYACTIVITYIDFIELD,
	Activity201Module_pb.GET201INFOREPLYISTURNBACKFIELD,
	Activity201Module_pb.GET201INFOREPLYINVITEPLAYERSFIELD,
	Activity201Module_pb.GET201INFOREPLYINVITECODEFIELD
}
Activity201Module_pb.GET201INFOREPLY_MSG.is_extendable = false
Activity201Module_pb.GET201INFOREPLY_MSG.extensions = {}
Activity201Module_pb.Get201InfoReply = protobuf.Message(Activity201Module_pb.GET201INFOREPLY_MSG)
Activity201Module_pb.Get201InfoRequest = protobuf.Message(Activity201Module_pb.GET201INFOREQUEST_MSG)
Activity201Module_pb.InvitePlayer = protobuf.Message(Activity201Module_pb.INVITEPLAYER_MSG)

return Activity201Module_pb
