-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallProp.lua

module("logic.extensions.pinball.view.PinBallProp", package.seeall)

local PinBallProp = class("PinBallProp")

function PinBallProp:ctor(go)
	self._posX = 0
	self._posY = 0
	self._direct = PinBallPropMgr.instance.propDirect
	self._speed = 1
	self._propType = PinBallEnum.PropType.None
	self._propGo = go
	self._width = 0
	self._height = 0
	self._screenWidth = 1280
	self._screenHeight = 720
	self._canUpdate = false
	self._isUsed = false
	self._extParams = nil
end

function PinBallProp:initParam(posX, posY, width, height, propType)
	self._posX = posX
	self._posY = posY
	self._width = width
	self._height = height
	self._propType = propType
	self._leftX = self._posX - self._width / 2 + PinBallBrickMapMgr.instance._mapInitX + self._width / 2
	self._rightX = self._posX + self._width / 2 + PinBallBrickMapMgr.instance._mapInitX + self._width / 2
	self._topY = self._posY + self._height / 2 + PinBallBrickMapMgr.instance._mapInitY + self._height / 2
	self._bottomY = self._posY - self._height / 2 + PinBallBrickMapMgr.instance._mapInitY + self._height / 2
	self._canUpdate = true
	self._isUsed = false

	GameUtil.SetActive(self._propGo, true)
end

function PinBallProp:initExtParam(params)
	self._extParams = params
end

function PinBallProp:setSpeed(speed)
	self._speed = speed
end

function PinBallProp:update()
	if self._canUpdate then
		self._posY = self._posY + self._direct.y * self._speed
		self._topY = self._posY + self._height / 2 + PinBallBrickMapMgr.instance._mapInitY + self._height / 2
		self._bottomY = self._posY - self._height / 2 + PinBallBrickMapMgr.instance._mapInitY + self._height / 2

		if self._propGo then
			GameUtil.setLocalPos(self._propGo, self._posX + PinBallBrickMapMgr.instance._mapInitX, self._posY + PinBallBrickMapMgr.instance._mapInitY, 0)
		end

		self:_check()
	end
end

function PinBallProp:_check()
	local boardData = PinBallBoardMgr.instance:getBoardData()
	local boardLeftX = boardData.posX - boardData.width / 2
	local boardRightX = boardData.posX + boardData.width / 2
	local boardTopY = boardData.posY + boardData.height / 2
	local boardBottomY = boardData.posY - boardData.height / 2
	local horizonTouch = boardLeftX <= self._leftX and boardRightX >= self._rightX
	local verticalTouch = boardBottomY <= self._topY and boardTopY >= self._bottomY

	if horizonTouch and verticalTouch then
		self:_useProp()

		self._canUpdate = false
		self._isUsed = true
	end
end

function PinBallProp:_useProp()
	return
end

function PinBallProp:getType()
	return self._propType
end

function PinBallProp:isOutScreen()
	return self._posY <= -self._screenHeight / 2
end

function PinBallProp:isUsed()
	return self._isUsed
end

function PinBallProp:reset()
	self._canUpdate = false

	if self._propGo then
		GameUtil.SetActive(self._propGo, false)
	end
end

function PinBallProp:destroy()
	if self._propGo then
		goutil.destroy(self._propGo)
	end
end

return PinBallProp
