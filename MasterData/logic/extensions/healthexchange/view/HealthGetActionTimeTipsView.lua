-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/healthexchange/view/HealthGetActionTimeTipsView.lua

module("logic.extensions.healthexchange.view.HealthGetActionTimeTipsView", package.seeall)

local M = class("HealthGetActionTimeTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("health_get_action_time_view_2140131538")
	self._txtMaxEnergy = self:getUIComponent("health_get_action_time_view_-382464426", UIComponentType.Text)
	self._txtOldEnergy = self:getUIComponent("health_get_action_time_view_-849964251", UIComponentType.Text)
	self._txtCurEnergy = self:getUIComponent("health_get_action_time_view_1439926822", UIComponentType.Text)
end

function M:destroyUI()
	self._btnClose = nil
	self._txtMaxEnergy = nil
	self._txtOldEnergy = nil
	self._txtCurEnergy = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:_onClickClose()
	self:close()
end

function M:onEnter()
	local info = self:getFirstParam() or {}
	local addEnergy = info.addEnergy or 0

	self:_refreshView(addEnergy)
end

function M:onExit()
	return
end

function M:_refreshView(addEnergy)
	local curEnergy = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode)
	local oldEnergy = curEnergy - addEnergy

	oldEnergy = oldEnergy < 0 and 0 or oldEnergy

	local maxEnergy = PlayerModel.instance:getEnergyLimit()
	local curEnergyColor = maxEnergy <= curEnergy and MoneyUtil.CurEnergyReachMaxColor or MoneyUtil.CurEnergyNormalColor
	local oldEnergyColor = maxEnergy <= oldEnergy and MoneyUtil.CurEnergyReachMaxColor or MoneyUtil.CurEnergyNormalColor

	self._txtMaxEnergy.text = string.format("<color=%s>/%s</color>", MoneyUtil.MaxEnergyColor, maxEnergy)
	self._txtOldEnergy.text = string.format("<color=%s>%s</color>", oldEnergyColor, oldEnergy)
	self._txtCurEnergy.text = string.format("<color=%s>%s</color>", curEnergyColor, curEnergy)
end

return M
