-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/model/MiniPartyInviteMO.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.model.MiniPartyInviteMO", package.seeall)

local MiniPartyInviteMO = class("MiniPartyInviteMO")

function MiniPartyInviteMO:ctor()
	self.friendInfo = {}
	self.inviteTime = 0
end

function MiniPartyInviteMO:init(info)
	if not LuaUtil.tableNotEmpty(self.friendInfo) then
		self.friendInfo = SocialPlayerMO.New()
	end

	self.friendInfo:init(info.friendInfo)

	self.inviteTime = info.inviteTime
end

return MiniPartyInviteMO
