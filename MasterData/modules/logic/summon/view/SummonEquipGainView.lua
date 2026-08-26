-- chunkname: @modules/logic/summon/view/SummonEquipGainView.lua

module("modules.logic.summon.view.SummonEquipGainView", package.seeall)

local SummonEquipGainView = class("SummonEquipGainView", BaseView)

function SummonEquipGainView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonEquipGainView:addEvents()
	return
end

function SummonEquipGainView:removeEvents()
	return
end

function SummonEquipGainView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonEquipSingleFinish, self.onSummonSingleAnimFinish, self)
end

function SummonEquipGainView:onSummonSingleAnimFinish()
	local summonResultMo = self.viewParam.summonResultMo
	local rewards = SummonModel.getRewardList({
		summonResultMo
	})

	if #rewards <= 0 then
		return
	end

	table.sort(rewards, SummonModel.sortRewards)

	for i, reward in ipairs(rewards) do
		if reward.materilType == MaterialEnum.MaterialType.Currency then
			local co, icon = ItemModel.instance:getItemConfigAndIcon(reward.materilType, reward.materilId)
			local quantity = reward.quantity
			local desc = luaLang("equip_duplicate_tips")
			local toastStr = string.format("%s\n%sX%s", desc, co.name, quantity)

			GameFacade.showToastWithIcon(ToastEnum.IconId, icon, toastStr)
		end
	end
end

return SummonEquipGainView
