-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameLightLineItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameLightLineItem", package.seeall)

local DianJiShiGameLightLineItem = class("DianJiShiGameLightLineItem", LuaCompBase)

function DianJiShiGameLightLineItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._goLeft = gohelper.findChild(self.go, "go_Left")
	self._goRight = gohelper.findChild(self.go, "go_Right")
	self._goBottom = gohelper.findChild(self.go, "go_Bottom")
	self._goTop = gohelper.findChild(self.go, "go_Top")
	self._imageLeftLine = gohelper.findChildImage(self.go, "go_Left/line")
	self._imageRightLine = gohelper.findChildImage(self.go, "go_Right/line")
	self._imageBottomLine = gohelper.findChildImage(self.go, "go_Bottom/line")
	self._imageTopLine = gohelper.findChildImage(self.go, "go_Top/line")
end

function DianJiShiGameLightLineItem:addEventListeners()
	return
end

function DianJiShiGameLightLineItem:removeEventListeners()
	return
end

function DianJiShiGameLightLineItem:onUpdateMO(cellInfo, cubeMap, blockPosIndex, canPlace, index)
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
	self._canPlace = canPlace
	self._index = index

	self:refreshUI()
end

function DianJiShiGameLightLineItem:refreshUI()
	if self._blockPosIndex then
		if not self._blockPosIndex[1] then
			local blockPosXIndex = 0

			if self._blockPosIndex then
				if not self._blockPosIndex[2] then
					local blockPosYIndex = 0
					local curPosXIndex, curPosYIndex = DianJiShiGameController.instance:cellPosIndex2GlobalIndex(self._posXIndex, self._posYIndex, blockPosXIndex, blockPosYIndex)
					local posX, posY = DianJiShiGameController.instance:posIndex2Pos(curPosXIndex, curPosYIndex, true)

					recthelper.setAnchor(self._tran, posX, posY)
					gohelper.setActive(self._goLeft, self:_checkIsEdge(self._posXIndex - 1, self._posYIndex))
					gohelper.setActive(self._goRight, self:_checkIsEdge(self._posXIndex + 1, self._posYIndex))
					gohelper.setActive(self._goTop, self:_checkIsEdge(self._posXIndex, self._posYIndex + 1))
					gohelper.setActive(self._goBottom, self:_checkIsEdge(self._posXIndex, self._posYIndex - 1))

					if self._canPlace then
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageLeftLine, "v3a8_dianjishi_game_blockselectedframe")
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageRightLine, "v3a8_dianjishi_game_blockselectedframe")
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageBottomLine, "v3a8_dianjishi_game_blockselectedframe2")
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageTopLine, "v3a8_dianjishi_game_blockselectedframe2")
					else
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageLeftLine, "v3a8_dianjishi_game_blockselectedframe_red")
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageRightLine, "v3a8_dianjishi_game_blockselectedframe_red")
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageBottomLine, "v3a8_dianjishi_game_blockselectedframe2_red")
						UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageTopLine, "v3a8_dianjishi_game_blockselectedframe2_red")
					end
				end
			end
		end
	end
end

function DianJiShiGameLightLineItem:_checkIsEdge(cellPosX, cellPosY)
	if self._cubeMap then
		return not self._cubeMap or not self._cubeMap[cellPosY]
	end
end

return DianJiShiGameLightLineItem
