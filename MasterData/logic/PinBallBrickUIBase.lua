-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBrickUIBase.lua

module("logic.extensions.pinball.view.PinBallBrickUIBase", package.seeall)

local PinBallBrickUIBase = class("PinBallBrickUIBase")

function PinBallBrickUIBase:ctor(go)
	self._health = 1
	self._uiGo = go
	self._brickType = PinBallEnum.BrickType.Default
end

function PinBallBrickUIBase:initParam(health, posX, posY, width, height, type)
	self._health = checknumber(health)
	self._posX = checknumber(posX)
	self._posY = checknumber(posY)
	self._width = checknumber(width)
	self._height = checknumber(height)
	self._brickType = type
end

function PinBallBrickUIBase:initUI()
	return
end

function PinBallBrickUIBase:updateUI()
	return
end

function PinBallBrickUIBase:destroy()
	goutil.destroy(self._uiGo)
end

function PinBallBrickUIBase:getType()
	return self._brickType
end

function PinBallBrickUIBase:reduceHealth()
	self._health = self._health - 1

	self:updateUI()
end

return PinBallBrickUIBase
