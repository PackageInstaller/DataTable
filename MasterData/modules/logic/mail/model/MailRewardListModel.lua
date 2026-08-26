-- chunkname: @modules/logic/mail/model/MailRewardListModel.lua

module("modules.logic.mail.model.MailRewardListModel", package.seeall)

local MailRewardListModel = class("MailRewardListModel", ListScrollModel)

function MailRewardListModel:setRewardList(rewardList)
	self._moList = {}

	if rewardList then
		for _, rewardMO in pairs(rewardList) do
			table.insert(self._moList, rewardMO)
		end
	end

	self:setList(self._moList)
end

MailRewardListModel.instance = MailRewardListModel.New()

return MailRewardListModel
