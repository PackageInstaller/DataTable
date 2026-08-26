-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateChessBoardItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessBoardItem", package.seeall)

local EliminateChessBoardItem = class("EliminateChessBoardItem", LuaCompBase)

function EliminateChessBoardItem:init(go)
	self._go = go
	self._tr = go.transform
	self._img_chessBoard = gohelper.findChildImage(self._go, "image")
end

function EliminateChessBoardItem:initData(data)
	self._data = data

	if self._data then
		local x = (self._data.x - 1) * EliminateEnum.ChessWidth
		local y = (self._data.y - 1) * EliminateEnum.ChessHeight
		local name = EliminateConfig.instance:getChessBoardIconPath(self._data:getChessBoardType())
		local isActive = not string.nilorempty(name)

		recthelper.setSize(self._tr, EliminateEnum.ChessWidth, EliminateEnum.ChessHeight)

		if isActive then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(self._img_chessBoard, name, false)
		end

		gohelper.setActiveCanvasGroup(self._go, isActive)
		transformhelper.setLocalPosXY(self._tr, x, y)
	end
end

function EliminateChessBoardItem:clear()
	self._data = nil
end

function EliminateChessBoardItem:onDestroy()
	self:clear()
	EliminateChessBoardItem.super.onDestroy(self)
end

return EliminateChessBoardItem
