-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreItemCell.lua

module("logic.extensions.store.view.StoreItemCell", package.seeall)

local M = class("StoreItemCell", ItemCell)

function M:dealSelect()
	GlobalDispatcher:dispatchEvent(self._data:getItemMarkType(), self._data, self._go, self._cellIndex, self._isShowTips, self._showTipsPassEvent, self._isHideGetWay, self._isHideLock)
end

return M
