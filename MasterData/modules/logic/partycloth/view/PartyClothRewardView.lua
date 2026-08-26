-- chunkname: @modules/logic/partycloth/view/PartyClothRewardView.lua

module("modules.logic.partycloth.view.PartyClothRewardView", package.seeall)

local PartyClothRewardView = class("PartyClothRewardView", BaseView)

function PartyClothRewardView:onInitView()
	self._goRewardRoot = gohelper.findChild(self.viewGO, "#go_RewardRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyClothRewardView:onClickModalMask()
	if self.canClose then
		self:closeThis()
	end
end

function PartyClothRewardView:onOpen()
	local materialDataMoList = self.viewParam

	for _, mo in ipairs(materialDataMoList) do
		local go = self:getResInst(PartyClothEnum.ResPath.PartItem, self._goRewardRoot)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyClothPartItem)
		local cfg = PartyClothConfig.instance:getClothConfig(mo.materilId)

		item:onUpdateMO({
			config = cfg
		})
	end

	TaskDispatcher.runDelay(self.delaySet, self, 0.7)
end

function PartyClothRewardView:delaySet()
	self.canClose = true
end

return PartyClothRewardView
