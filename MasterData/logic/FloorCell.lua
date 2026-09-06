-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/FloorCell.lua

module("logic.extensions.jumpfloor.view.game.FloorCell", package.seeall)

local FloorCell = class("FloorCell")
local horizontal = 200
local vertical = 100

FloorCell.Vertical = vertical

function FloorCell:ctor(luaComponentContainer)
	self._mainGo = luaComponentContainer.gameObject
	self._rootRect = self._mainGo:GetComponent(goutil.Type_RectTransform)
	self._buffGo = goutil.findChild(self._mainGo, "buff")
	self._txtBuff = goutil.findChildTextComponent(self._mainGo, "buff/txt")
	self._buffSpriteChange = self._buffGo:GetComponent(ComponentType.UIImageSpriteChange)
	self._dest = goutil.findChild(self._mainGo, "dest")

	goutil.setActive(self._buffGo, false)
	goutil.setActive(self._dest, false)

	self._txtBuff.text = ""
end

function FloorCell:init(data, gameMode)
	self._jumpFloorCellData = data
	self._anchoredPosition = self:_getPosByColAndRow(data.col, data.row)
	self._rootRect.anchoredPosition = self._anchoredPosition

	local isShow = self:_isShowBuff()

	goutil.setActive(self._dest, gameMode == JumpFloorModel.LevelMode and self._jumpFloorCellData:getIsDestination())
	goutil.setActive(self._buffGo, isShow)

	if isShow then
		self._txtBuff.text = self:_getBuffName(self._jumpFloorCellData:getCellType()) .. ":" .. self._jumpFloorCellData:getSkipCellStep()

		self._buffSpriteChange:SetState(self:_getBuffState(data:getCellType(), data:getSkipCellStep()))
	end
end

function FloorCell:_getBuffState(cellType, skipCellStep)
	if cellType == JumpFloorCellData.ECellType.Trap then
		return 0
	elseif cellType == JumpFloorCellData.ECellType.Shield then
		return 1
	elseif cellType == JumpFloorCellData.ECellType.SkipCell then
		return skipCellStep >= 0 and 2 or 3
	else
		return 0
	end
end

function FloorCell:_isShowBuff()
	if self._jumpFloorCellData:getCellType() == JumpFloorCellData.ECellType.Empty or self._jumpFloorCellData:getCellType() == JumpFloorCellData.ECellType.Normal then
		return false
	else
		return self._jumpFloorCellData:isBuffAvailable()
	end
end

function FloorCell:_getBuffName(buffType)
	if buffType == JumpFloorCellData.ECellType.Trap then
		return "陷阱"
	elseif buffType == JumpFloorCellData.ECellType.Shield then
		return "护盾"
	elseif buffType == JumpFloorCellData.ECellType.SkipCell then
		return "龙卷风"
	else
		return "无"
	end
end

function FloorCell:reset()
	if self._delAnimTween then
		self._delAnimTween:Kill()

		self._delAnimTween = nil
	end

	if self._addAnimTween then
		self._addAnimTween:Kill()

		self._addAnimTween = nil
	end
end

function FloorCell:getMainGo()
	return self._mainGo
end

function FloorCell:_getPosByColAndRow(col, row)
	local pos = Vector2.New(0, 0)
	local halfHorizontal = (col - 1) * horizontal / 2
	local firstPosX = halfHorizontal * -1

	pos.x = firstPosX + (row - 1) * horizontal
	pos.y = (col - 1) * vertical

	return pos
end

function FloorCell:getCol()
	return self._jumpFloorCellData:getCol()
end

function FloorCell:getRow()
	return self._jumpFloorCellData:getRow()
end

function FloorCell:isDataEqual(jumpFloorCellData)
	return self._jumpFloorCellData == jumpFloorCellData
end

function FloorCell:getAnchoredPosition()
	return self._anchoredPosition
end

function FloorCell:doDelAnimation()
	local distanceY = -300
	local targetPos = self._anchoredPosition + Vector2.New(0, distanceY)

	self._delAnimTween = self._rootRect:DOAnchorPos(targetPos, BaseJumpFloorGame.AnimationTime)
end

function FloorCell:doAddAnimation()
	local distanceY = 300
	local targetPos = self._anchoredPosition

	self._rootRect.anchoredPosition = self._anchoredPosition + Vector2.New(0, distanceY)
	self._addAnimTween = self._rootRect:DOAnchorPos(targetPos, BaseJumpFloorGame.AnimationTime)
end

function FloorCell:clearBuff()
	goutil.setActive(self._buffGo, false)

	if isShow then
		self._txtBuff.text = ""
	end
end

function FloorCell:setDestition()
	goutil.setActive(self._dest, true)
end

return FloorCell
