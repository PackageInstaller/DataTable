-- chunkname: @modules/logic/act201/model/Activity201Mo.lua

module("modules.logic.act201.model.Activity201Mo", package.seeall)

local Activity201Mo = pureTable("Activity201Mo")

function Activity201Mo:ctor()
	self.invitePlayers = {}
end

function Activity201Mo:init(info)
	self.activityId = info.activityId
	self.isTurnBack = info.isTurnback
	self.inviteCode = info.inviteCode

	self:refreshInvitaPlayerInfo(info.invitePlayers)
end

function Activity201Mo:refreshInvitaPlayerInfo(invitePlayers)
	tabletool.clear(self.invitePlayers)

	if invitePlayers and #invitePlayers > 0 then
		for _, inviteInfo in ipairs(invitePlayers) do
			local infoMo = {}

			infoMo.name = inviteInfo.name
			infoMo.userId = inviteInfo.userId
			infoMo.portrait = inviteInfo.portrait
			infoMo.roleType = inviteInfo.roleType

			table.insert(self.invitePlayers, infoMo)
		end
	end
end

return Activity201Mo
