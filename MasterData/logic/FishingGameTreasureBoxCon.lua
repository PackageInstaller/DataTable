-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameTreasureBoxCon.lua

module("logic.extensions.fishinggame.model.FishingGameTreasureBoxCon", package.seeall)

local FishingGameTreasureBoxCon = class("FishingGameTreasureBoxCon", FishingGameFishCon)

function FishingGameTreasureBoxCon:setGray(isGray)
	FishingGameTreasureBoxCon.super.setGray(self, false)
end

return FishingGameTreasureBoxCon
