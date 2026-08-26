-- chunkname: @modules/logic/survival/model/map/SurvivalShrinkInfoMo.lua

module("modules.logic.survival.model.map.SurvivalShrinkInfoMo", package.seeall)

local SurvivalShrinkInfoMo = pureTable("SurvivalShrinkInfoMo")

function SurvivalShrinkInfoMo:init(data)
	self.round = data.round
	self.startTime = data.startTime
	self.endTime = data.endTime
	self.finalCircle = data.finalCircle
end

return SurvivalShrinkInfoMo
