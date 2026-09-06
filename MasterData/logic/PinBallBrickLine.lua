-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBrickLine.lua

module("logic.extensions.pinball.view.PinBallBrickLine", package.seeall)

local PinBallBrickLine = class("PinBallBrickLine", PinBallBrickBase)

function PinBallBrickLine:initExtParam(param)
	if param then
		local params = string.split(param, "#")

		if params then
			if not params[1] then
				self._brickKey = "init"
			end
		end
	else
		self._brickKey = "init"
	end
end

function PinBallBrickLine:initUI()
	self._imgBrickChangeComp = goutil.findChild(self._brickGo, "imgBrick"):GetComponent(ComponentType.UIImageSpriteChange)

	self._imgBrickChangeComp:SetState(self._health - 1)
end

function PinBallBrickLine:updateUI()
	if self._health <= 0 then
		self._brickGo:SetActive(false)

		if self._propType > 0 and not self._hasCreateProp then
			PinBallPropMgr.instance:getProp(self._propType, self._posX, self._posY, self._propExtParam)

			self._hasCreateProp = true
		end

		PinBallBrickMapMgr.instance:releaseBrickNum()
	end

	if self._imgBrickChangeComp then
		self._imgBrickChangeComp:SetState(self._health - 1)
	end
end

function PinBallBrickLine:reduceHealth()
	self._health = self._health - 1

	if self._health <= 0 and self._brickKey then
		PinBallBrickMapMgr.instance:clearAllLineBrickByKey(self._brickKey)
	end
end

function PinBallBrickLine:getBrickKey()
	return self._brickKey
end

return PinBallBrickLine
