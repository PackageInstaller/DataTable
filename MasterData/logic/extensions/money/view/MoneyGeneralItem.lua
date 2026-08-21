-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/view/MoneyGeneralItem.lua

module("logic.extensions.money.view.MoneyGeneralItem", package.seeall)

local M = class("MoneyGeneralItem", MoneyBaseItem)

function M:_onClickAddBtn()
	GlobalDispatcher:dispatchEvent(EventType.TOP_MONEY_ITEM_ADD_CLICK, self:getMainGo(), self:getMoneyCode(), self:getMoneyShowType())
end

function M:_onClickJumpBtn()
	if self:getMoneyCode() == CommEnum.CurrencyCodeEnum.TlCode then
		self:_onClickAddBtn()
	else
		local isPassEvent = self:getJumpBtnPassEvent()

		GlobalDispatcher:dispatchEvent(EventType.TOP_MONEY_ITEM_JUMP_CLICK, self:getMainGo(), self:getMoneyCode(), self:getMoneyShowType(), isPassEvent)
	end
end

return M
