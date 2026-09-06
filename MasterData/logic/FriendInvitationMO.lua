-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/FriendInvitationMO.lua

module("logic.extensions.petzoo.model.FriendInvitationMO", package.seeall)

local FriendInvitationMO = class("FriendInvitationMO")

function FriendInvitationMO:ctor()
	self.matchId = 0
	self.animalMo = nil
	self.startTime = nil
	self.friendMo = nil
	self.friendId = nil
end

return FriendInvitationMO
