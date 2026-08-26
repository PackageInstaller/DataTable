-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/model/HeroInvitationListModel.lua

module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationListModel", package.seeall)

local HeroInvitationListModel = class("HeroInvitationListModel", ListScrollModel)

function HeroInvitationListModel:refreshList()
	local invitations = HeroInvitationConfig.instance:getInvitationList()

	self.count = #invitations
	self.finishCount = 0

	local list = {}

	for i, v in ipairs(invitations) do
		local state = HeroInvitationModel.instance:getInvitationState(v.id)

		if state == HeroInvitationEnum.InvitationState.Finish then
			self.finishCount = self.finishCount + 1
		end

		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("id"))
	self:setList(list)
end

HeroInvitationListModel.instance = HeroInvitationListModel.New()

return HeroInvitationListModel
