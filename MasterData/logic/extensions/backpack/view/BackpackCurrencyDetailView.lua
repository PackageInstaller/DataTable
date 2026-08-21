-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackCurrencyDetailView.lua

module("logic.extensions.backpack.view.BackpackCurrencyDetailView", package.seeall)

local M = class("BackpackCurrencyDetailView", BackpackItemDetailView)

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData

	goutil.setActive(self._btnUse.gameObject, self._itemData:getJumpId() > 0)
	self:setScrollSize(self._btnUse.gameObject.activeSelf)
end

function M:_onClickUseBtn()
	local jumpId = self._itemData:getJumpId()

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

return M
