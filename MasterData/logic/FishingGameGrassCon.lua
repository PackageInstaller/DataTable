-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameGrassCon.lua

module("logic.extensions.fishinggame.model.FishingGameGrassCon", package.seeall)

local FishingGameGrassCon = class("FishingGameGrassCon", FishingGameFishCon)

function FishingGameGrassCon:setGray(isGray)
	FishingGameGrassCon.super.setGray(self, false)
end

return FishingGameGrassCon
