-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameElectricEel.lua

module("logic.extensions.fishinggame.model.FishingGameElectricEel", package.seeall)

local FishingGameElectricEel = class("FishingGameElectricEel", FishingGameFish)

function FishingGameElectricEel:getHookFreezeTimer()
	return math.max(0.5, checknumber(self.effectNum))
end

function FishingGameElectricEel:shouldDestroyOnReachWater()
	return true
end

return FishingGameElectricEel
