-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameGrass.lua

module("logic.extensions.fishinggame.model.FishingGameGrass", package.seeall)

local FishingGameGrass = class("FishingGameGrass", FishingGameFish)

function FishingGameGrass:isMovingFish()
	return false
end

function FishingGameGrass:shouldResetToOriginAfterThrow()
	return true
end

function FishingGameGrass:resetToOrigin()
	FishingGameGrass.super.resetToOrigin(self)
	self:setCanHook(true)
end

function FishingGameGrass:getHookPriority()
	return 1000
end

function FishingGameGrass:isIdleOutOfScene(sceneMinX, sceneMaxX, sceneMaxY, waterY)
	return false
end

function FishingGameGrass:_updateIdle(deltaTime)
	return
end

return FishingGameGrass
