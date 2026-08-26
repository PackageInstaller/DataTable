-- chunkname: @modules/logic/rouge/view/RougePickAssistItem.lua

module("modules.logic.rouge.view.RougePickAssistItem", package.seeall)

local RougePickAssistItem = class("RougePickAssistItem", PickAssistItem)

function RougePickAssistItem:_editableInitView()
	RougePickAssistItem.super._editableInitView(self)
	self:_initCapacity()
end

function RougePickAssistItem:_initCapacity()
	local volumeGo = gohelper.findChild(self.viewGO, "volume")

	self._capacityComp = RougeCapacityComp.Add(volumeGo, nil, nil, true)

	self._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function RougePickAssistItem:onUpdateMO(mo)
	RougePickAssistItem.super.onUpdateMO(self, mo)

	local heroMO = self._mo.heroMO
	local lv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(heroMO.heroId)

	if lv > heroMO.level then
		self._heroItem:setBalanceLv(lv)
	end

	local capacity = RougeConfig1.instance:getRoleCapacity(mo.heroMO.config.rare)

	self._capacity = capacity

	self._capacityComp:updateMaxNum(capacity)
end

function RougePickAssistItem:_checkClick()
	local capacityParams = RougeController.instance.pickAssistViewParams

	if capacityParams.curCapacity + self._capacity > capacityParams.totalCapacity then
		GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

		return false
	end

	return true
end

return RougePickAssistItem
