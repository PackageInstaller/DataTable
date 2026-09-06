-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBrickBase.lua

module("logic.extensions.pinball.view.PinBallBrickBase", package.seeall)

local PinBallBrickBase = class("PinBallBrickBase")

function PinBallBrickBase:ctor(go)
	self._health = 1
	self._brickGo = go
	self._propType = 0
	self._propParams = nil
	self._hasCreateProp = false
end

function PinBallBrickBase:initParam(name, health, posX, posY, type, propType, propExtParam)
	self._brickName = name
	self._health = health
	self._posX = posX
	self._posY = posY
	self._propType = checknumber(propType)
	self._propExtParam = propExtParam
	self._brickType = type

	GameUtil.setLocalPos(self._brickGo, posX, posY, 0)
	GameUtil.SetActive(self._brickGo, true)
	self:initUI()
end

function PinBallBrickBase:initExtParam()
	return
end

function PinBallBrickBase:initPropParam(propParams)
	self._propParams = propParams
end

function PinBallBrickBase:getGameObject()
	return self._brickGo
end

function PinBallBrickBase:getBrickType()
	return self._brickType
end

function PinBallBrickBase:initUI()
	self._imgBrickChangeComp = goutil.findChild(self._brickGo, "imgBrick"):GetComponent(ComponentType.UIImageSpriteChange)

	if self._imgBrickChangeComp then
		self._imgBrickChangeComp:SetState(self._health - 1)
	end
end

function PinBallBrickBase:getHealth()
	return self._health
end

function PinBallBrickBase:reduceHealth()
	self._health = self._health - 1
end

function PinBallBrickBase:reduceAllHealth()
	self._health = 0
end

function PinBallBrickBase:getPos()
	return self._posX, self._posY
end

function PinBallBrickBase:updateUI()
	if self._health <= 0 then
		self._brickGo:SetActive(false)

		if self._propType > 0 and not self._hasCreateProp then
			PinBallPropMgr.instance:getProp(self._propType, self._posX, self._posY, self._propExtParam)

			self._hasCreateProp = true
		end

		return
	end

	if self._imgBrickChangeComp then
		self._imgBrickChangeComp:SetState(self._health - 1)
	end
end

function PinBallBrickBase:reset()
	GameUtil.SetActive(self._brickGo, false)
end

function PinBallBrickBase:destroy()
	goutil.destroy(self._brickGo)
end

return PinBallBrickBase
