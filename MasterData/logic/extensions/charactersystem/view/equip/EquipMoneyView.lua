-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipMoneyView.lua

module("logic.extensions.charactersystem.view.equip.EquipMoneyView", package.seeall)

local M = class("EquipMoneyView", MoneyView)

function M:buildUI()
	if not self._topCurrencyGo then
		self._topCurrencyGo = self:getGoByPath("top_currency")
	end

	local moneyInfo = MoneyUtil.getMoneyInfoByShowType(self._moneyShowType)

	if not moneyInfo.defaultHide and not self._hasInit then
		self:_createMoneyItem(moneyInfo.moneyCodes)
	end
end

return M
