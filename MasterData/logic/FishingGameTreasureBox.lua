-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameTreasureBox.lua

module("logic.extensions.fishinggame.model.FishingGameTreasureBox", package.seeall)

local FishingGameTreasureBox = class("FishingGameTreasureBox", FishingGameFish)

function FishingGameTreasureBox:isMovingFish()
	return false
end

function FishingGameTreasureBox:getHookPriority()
	return 2000
end

function FishingGameTreasureBox:isIdleOutOfScene(sceneMinX, sceneMaxX, sceneMaxY, waterY)
	return false
end

function FishingGameTreasureBox:_updateIdle(deltaTime)
	return
end

return FishingGameTreasureBox
