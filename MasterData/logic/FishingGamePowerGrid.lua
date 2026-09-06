-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGamePowerGrid.lua

module("logic.extensions.fishinggame.model.FishingGamePowerGrid", package.seeall)

local FishingGamePowerGrid = class("FishingGamePowerGrid", FishingGameFish)

function FishingGamePowerGrid:isMovingFish()
	return false
end

function FishingGamePowerGrid:shouldInterruptAttackOnHook()
	return true
end

function FishingGamePowerGrid:getReachWaterStunTimer()
	return math.max(0.5, checknumber(self.effectNum))
end

function FishingGamePowerGrid:shouldDestroyOnReachWater()
	return true
end

function FishingGamePowerGrid:getHookPriority()
	return 5000
end

function FishingGamePowerGrid:isIdleOutOfScene(sceneMinX, sceneMaxX, sceneMaxY, waterY)
	return self.position.y >= checknumber(waterY)
end

function FishingGamePowerGrid:_updateIdle(deltaTime)
	self.position.y = self.position.y + self.speed * deltaTime

	self:_syncRect()
end

return FishingGamePowerGrid
