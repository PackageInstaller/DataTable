-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/model/MiniPartyFriendMO.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.model.MiniPartyFriendMO", package.seeall)

local MiniPartyFriendMO = class("MiniPartyFriendMO")

function MiniPartyFriendMO:ctor()
	self.friendUid = 0
	self.isTeam = false
	self.isInvite = false
end

function MiniPartyFriendMO:init(info)
	self.friendUid = info.friendUid
	self.isTeam = info.isTeam
	self.isInvite = info.isInvite
end

return MiniPartyFriendMO
