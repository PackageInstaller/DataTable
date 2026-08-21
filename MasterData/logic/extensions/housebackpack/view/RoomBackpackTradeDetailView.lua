-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackTradeDetailView.lua

module("logic.extensions.housebackpack.view.RoomBackpackTradeDetailView", package.seeall)

local M = class("RoomBackpackTradeDetailView", RoomBackpackItemDetailView)

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData

	IconLoader.setSprite(self._imgIconShadow, IconType.ItemIcon, itemData:getIcon())
	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemData:getIcon())
end

return M
