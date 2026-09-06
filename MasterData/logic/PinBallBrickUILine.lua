-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBrickUILine.lua

module("logic.extensions.pinball.view.PinBallBrickUILine", package.seeall)

local PinBallBrickUILine = class("PinBallBrickUILine", PinBallBrickUIBase)

function PinBallBrickUILine:initParam(health, posX, posY, width, height, type)
	self._health = checknumber(health)
	self._posX = checknumber(posX)
	self._posY = checknumber(posY)
	self._width = checknumber(width)
	self._height = checknumber(height)
	self._brickType = type

	self:initUI()
end

function PinBallBrickUILine:initUI()
	local img = goutil.findChild(self._uiGo, "img")

	GameUtil.setWidth(img, self._width)
	GameUtil.setHeight(img, self._height)
	GameUtil.setLocalPos(self._uiGo, self._posX, self._posY, 0)
end

function PinBallBrickUILine:updateUI()
	GameUtil.SetActive(self._uiGo, self._health > 0)
end

return PinBallBrickUILine
