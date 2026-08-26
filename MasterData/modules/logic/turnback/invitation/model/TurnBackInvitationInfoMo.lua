-- chunkname: @modules/logic/turnback/invitation/model/TurnBackInvitationInfoMo.lua

module("modules.logic.turnback.invitation.model.TurnBackInvitationInfoMo", package.seeall)

local TurnBackInvitationInfoMo = pureTable("TurnBackInvitationInfoMo")

function TurnBackInvitationInfoMo:ctor()
	self.invitePlayers = {}
end

function TurnBackInvitationInfoMo:init(info)
	self.activityId = info.activityId
	self.isTurnBack = info.isTurnback
	self.inviteCode = info.inviteCode

	self:refreshInvitaPlayerInfo(info.invitePlayers)
end

function TurnBackInvitationInfoMo:refreshInvitaPlayerInfo(invitePlayers)
	tabletool.clear(self.invitePlayers)

	if invitePlayers and #invitePlayers > 0 then
		for _, inviteInfo in ipairs(invitePlayers) do
			local infoMo = {}

			infoMo.name = inviteInfo.name
			infoMo.userId = inviteInfo.userId
			infoMo.portrait = inviteInfo.portrait

			table.insert(self.invitePlayers, infoMo)
		end
	end
end

return TurnBackInvitationInfoMo
