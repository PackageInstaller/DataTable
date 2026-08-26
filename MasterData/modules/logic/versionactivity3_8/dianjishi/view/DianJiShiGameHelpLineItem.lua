-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameHelpLineItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameHelpLineItem", package.seeall)

local DianJiShiGameHelpLineItem = class("DianJiShiGameHelpLineItem", LuaCompBase)

function DianJiShiGameHelpLineItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._goLeft = gohelper.findChild(self.go, "go_Left")
	self._goRight = gohelper.findChild(self.go, "go_Right")
	self._goBottom = gohelper.findChild(self.go, "go_Bottom")
	self._goTop = gohelper.findChild(self.go, "go_Top")
end

function DianJiShiGameHelpLineItem:addEventListeners()
	return
end

function DianJiShiGameHelpLineItem:removeEventListeners()
	return
end

function DianJiShiGameHelpLineItem:onUpdateMO(cellInfo, cubeMap, blockPosIndex, index)
	self._cellInfo = cellInfo
	self._cubeMap = cubeMap
	self._posIndex = self._cellInfo

	if self._posIndex then
		self._posXIndex = self._posIndex[1] or 0
	end

	if self._posIndex then
		self._posYIndex = self._posIndex[2] or 0
	end

	self._blockPosIndex = blockPosIndex

	self:refreshUI()
end

function DianJiShiGameHelpLineItem:refreshUI()
	if self._blockPosIndex then
		if not self._blockPosIndex[1] then
			local blockPosXIndex = 0

			if self._blockPosIndex then
				if not self._blockPosIndex[2] then
					local blockPosYIndex = 0
					local curPosXIndex, curPosYIndex = DianJiShiGameController.instance:cellPosIndex2GlobalIndex(self._posXIndex, self._posYIndex, blockPosXIndex, blockPosYIndex)
					local posX, posY = DianJiShiGameController.instance:posIndex2Pos(curPosXIndex, curPosYIndex, true)

					recthelper.setAnchor(self._tran, posX, posY)

					local left = self:_checkIsEdge(self._posXIndex - 1, self._posYIndex)
					local right = self:_checkIsEdge(self._posXIndex + 1, self._posYIndex)
					local top = self:_checkIsEdge(self._posXIndex, self._posYIndex + 1)
					local bottom = self:_checkIsEdge(self._posXIndex, self._posYIndex - 1)

					gohelper.setActive(self._goLeft, self:_checkIsEdge(self._posXIndex - 1, self._posYIndex))
					gohelper.setActive(self._goRight, self:_checkIsEdge(self._posXIndex + 1, self._posYIndex))
					gohelper.setActive(self._goTop, self:_checkIsEdge(self._posXIndex, self._posYIndex + 1))
					gohelper.setActive(self._goBottom, self:_checkIsEdge(self._posXIndex, self._posYIndex - 1))
				end
			end
		end
	end
end

function DianJiShiGameHelpLineItem:_checkIsEdge(cellPosX, cellPosY)
	if self._cubeMap then
		return not self._cubeMap or not self._cubeMap[cellPosY]
	end
end

return DianJiShiGameHelpLineItem
