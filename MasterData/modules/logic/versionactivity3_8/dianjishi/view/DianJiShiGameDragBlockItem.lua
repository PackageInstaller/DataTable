-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameDragBlockItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameDragBlockItem", package.seeall)

local DianJiShiGameDragBlockItem = class("DianJiShiGameDragBlockItem", LuaCompBase)

function DianJiShiGameDragBlockItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DianJiShiGameDragBlockItem)
end

function DianJiShiGameDragBlockItem:init(go)
	self.go = go
	self._goIcon = gohelper.findChild(self.go, "go_Icon")
	self._tran = self.go.transform
	self._tranParent = self._tran.parent.transform
end

function DianJiShiGameDragBlockItem:addEventListeners()
	return
end

function DianJiShiGameDragBlockItem:removeEventListeners()
	return
end

function DianJiShiGameDragBlockItem:addBlockGo(goTemplate)
	local goBlock = gohelper.clone(goTemplate, self._goIcon)

	self._baseBlockItem = DianJiShiGameBaseBlockItem.Get(goBlock)

	self._baseBlockItem:keepFrontIconVisible(true)
	self._baseBlockItem:setTagScale(DianJiShiGameEnum.DragBlockTagScale, DianJiShiGameEnum.DragBlockTagScale)
end

function DianJiShiGameDragBlockItem:onUpdateMO(blockInfo)
	self._blockInfo = blockInfo
	self._blockSize = self._blockInfo and self._blockInfo.size
	self._cellWidth, self._cellHeight = DianJiShiGameModel.instance:getCellSize()
	self._blockWidth = ((self._blockSize or nil) and (self._blockSize[1] or 0)) * self._cellWidth
	self._blockHeight = ((self._blockSize or nil) and (self._blockSize[2] or 0)) * self._cellHeight

	self:setVisible(true)
	self:refreshUI()
end

function DianJiShiGameDragBlockItem:refreshUI()
	self._baseBlockItem:onUpdateMO(self._blockInfo)
	self:refreshPosition()
end

function DianJiShiGameDragBlockItem:refreshPosition()
	if not self._blockInfo then
		return
	end

	local startPosX, startPosY = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), self._tranParent)
	local endPosX = startPosX - self._blockWidth
	local endPosY = startPosY + self._blockHeight

	recthelper.setAnchor(self._tran, endPosX, endPosY)

	local posXIndex, posYIndex = DianJiShiGameController.instance:pos2PosIndex(endPosX, endPosY)

	return posXIndex, posYIndex
end

function DianJiShiGameDragBlockItem:setVisible(isVisible)
	gohelper.setActive(self.go, isVisible)
end

return DianJiShiGameDragBlockItem
