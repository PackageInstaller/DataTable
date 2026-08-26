-- chunkname: @modules/proto/Activity171Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity171Module_pb", package.seeall)

local Activity171Module_pb = {}

Activity171Module_pb.INVITEPLAYER_MSG = protobuf.Descriptor()
Activity171Module_pb.INVITEPLAYERUSERIDFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.INVITEPLAYERNAMEFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.GET171INFOREPLY_MSG = protobuf.Descriptor()
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.GET171INFOREQUEST_MSG = protobuf.Descriptor()
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.name = "userId"
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.full_name = ".InvitePlayer.userId"
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.number = 1
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.index = 0
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.label = 1
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.has_default_value = false
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.default_value = 0
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.type = 3
Activity171Module_pb.INVITEPLAYERUSERIDFIELD.cpp_type = 2
Activity171Module_pb.INVITEPLAYERNAMEFIELD.name = "name"
Activity171Module_pb.INVITEPLAYERNAMEFIELD.full_name = ".InvitePlayer.name"
Activity171Module_pb.INVITEPLAYERNAMEFIELD.number = 2
Activity171Module_pb.INVITEPLAYERNAMEFIELD.index = 1
Activity171Module_pb.INVITEPLAYERNAMEFIELD.label = 1
Activity171Module_pb.INVITEPLAYERNAMEFIELD.has_default_value = false
Activity171Module_pb.INVITEPLAYERNAMEFIELD.default_value = ""
Activity171Module_pb.INVITEPLAYERNAMEFIELD.type = 9
Activity171Module_pb.INVITEPLAYERNAMEFIELD.cpp_type = 9
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.name = "portrait"
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.full_name = ".InvitePlayer.portrait"
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.number = 3
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.index = 2
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.label = 1
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.has_default_value = false
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.default_value = 0
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.type = 5
Activity171Module_pb.INVITEPLAYERPORTRAITFIELD.cpp_type = 1
Activity171Module_pb.INVITEPLAYER_MSG.name = "InvitePlayer"
Activity171Module_pb.INVITEPLAYER_MSG.full_name = ".InvitePlayer"
Activity171Module_pb.INVITEPLAYER_MSG.nested_types = {}
Activity171Module_pb.INVITEPLAYER_MSG.enum_types = {}
Activity171Module_pb.INVITEPLAYER_MSG.fields = {
	Activity171Module_pb.INVITEPLAYERUSERIDFIELD,
	Activity171Module_pb.INVITEPLAYERNAMEFIELD,
	Activity171Module_pb.INVITEPLAYERPORTRAITFIELD
}
Activity171Module_pb.INVITEPLAYER_MSG.is_extendable = false
Activity171Module_pb.INVITEPLAYER_MSG.extensions = {}
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.full_name = ".Get171InfoReply.activityId"
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.number = 1
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.index = 0
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.label = 1
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.type = 5
Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.name = "isTurnback"
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.full_name = ".Get171InfoReply.isTurnback"
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.number = 2
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.index = 1
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.label = 1
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.has_default_value = false
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.default_value = false
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.type = 8
Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD.cpp_type = 7
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.name = "invitePlayers"
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.full_name = ".Get171InfoReply.invitePlayers"
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.number = 3
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.index = 2
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.label = 3
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.has_default_value = false
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.default_value = {}
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.message_type = Activity171Module_pb.INVITEPLAYER_MSG
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.type = 11
Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD.cpp_type = 10
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.name = "inviteCode"
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.full_name = ".Get171InfoReply.inviteCode"
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.number = 4
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.index = 3
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.label = 1
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.has_default_value = false
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.default_value = ""
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.type = 9
Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD.cpp_type = 9
Activity171Module_pb.GET171INFOREPLY_MSG.name = "Get171InfoReply"
Activity171Module_pb.GET171INFOREPLY_MSG.full_name = ".Get171InfoReply"
Activity171Module_pb.GET171INFOREPLY_MSG.nested_types = {}
Activity171Module_pb.GET171INFOREPLY_MSG.enum_types = {}
Activity171Module_pb.GET171INFOREPLY_MSG.fields = {
	Activity171Module_pb.GET171INFOREPLYACTIVITYIDFIELD,
	Activity171Module_pb.GET171INFOREPLYISTURNBACKFIELD,
	Activity171Module_pb.GET171INFOREPLYINVITEPLAYERSFIELD,
	Activity171Module_pb.GET171INFOREPLYINVITECODEFIELD
}
Activity171Module_pb.GET171INFOREPLY_MSG.is_extendable = false
Activity171Module_pb.GET171INFOREPLY_MSG.extensions = {}
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.full_name = ".Get171InfoRequest.activityId"
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.number = 1
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.index = 0
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.label = 1
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.type = 5
Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity171Module_pb.GET171INFOREQUEST_MSG.name = "Get171InfoRequest"
Activity171Module_pb.GET171INFOREQUEST_MSG.full_name = ".Get171InfoRequest"
Activity171Module_pb.GET171INFOREQUEST_MSG.nested_types = {}
Activity171Module_pb.GET171INFOREQUEST_MSG.enum_types = {}
Activity171Module_pb.GET171INFOREQUEST_MSG.fields = {
	Activity171Module_pb.GET171INFOREQUESTACTIVITYIDFIELD
}
Activity171Module_pb.GET171INFOREQUEST_MSG.is_extendable = false
Activity171Module_pb.GET171INFOREQUEST_MSG.extensions = {}
Activity171Module_pb.Get171InfoReply = protobuf.Message(Activity171Module_pb.GET171INFOREPLY_MSG)
Activity171Module_pb.Get171InfoRequest = protobuf.Message(Activity171Module_pb.GET171INFOREQUEST_MSG)
Activity171Module_pb.InvitePlayer = protobuf.Message(Activity171Module_pb.INVITEPLAYER_MSG)

return Activity171Module_pb
