-- chunkname: @modules/logic/versionactivity3_9/bird/model/V3a9BirdPipeMO.lua

module("modules.logic.versionactivity3_9.bird.model.V3a9BirdPipeMO", package.seeall)

local V3a9BirdPipeMO = pureTable("V3a9BirdPipeMO")

function V3a9BirdPipeMO:initMO(posX, topY, bottomY)
	self._posX = posX
	self._isPass = false
	self._topPosY = topY
	self._bottomPosY = bottomY
end

function V3a9BirdPipeMO:getPosX()
	return self._posX or 0
end

function V3a9BirdPipeMO:setPosX(x)
	self._posX = x
end

function V3a9BirdPipeMO:moveX(distance)
	self._posX = self._posX - distance
end

function V3a9BirdPipeMO:getTopBottomY()
	return self._topPosY or 0, self._bottomPosY or 0
end

function V3a9BirdPipeMO:setPass()
	self._isPass = true
end

function V3a9BirdPipeMO:isPass()
	return self._isPass
end

return V3a9BirdPipeMO
