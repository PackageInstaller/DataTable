-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/EliteStagePoint.lua

require("dm.gameplay.stage.model.StagePoint")

EliteStagePoint = class("EliteStagePoint", StagePoint, _M)

EliteStagePoint:has("_challengeTimes", {
	is = "rw"
})
EliteStagePoint:has("_resetTimes", {
	is = "rw"
})

function EliteStagePoint:initialize(pointId, type)
	super.initialize(self, pointId)
end

function EliteStagePoint:sync(data)
	super.sync(self, data)

	if data.challengeTimes then
		self._challengeTimes = data.challengeTimes.value
	end

	if data.resetTimes then
		self._resetTimes = data.resetTimes.value
	end
end

function EliteStagePoint:getPointType()
	return self._config.PointType
end

function EliteStagePoint:canWipeOnce()
	local needStars = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stage_Sweep_Stars", "content")

	if self:isPass() and needStars <= self:getStarCount() then
		return true
	end

	return false
end

function EliteStagePoint:getMaxChallengeTimes()
	local config = ConfigReader:getRecordById("Reset", "EliteStage_FreeTimes")

	return config.ResetSystem.setValue
end

function EliteStagePoint:getChallengeTimes()
	if self:isPass() then
		return self._challengeTimes
	else
		return self:getMaxChallengeTimes()
	end
end

function EliteStagePoint:getResetCost()
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "EliteStage_RestCost", "content")

	if self._resetTimes + 1 > #config then
		return config[#config]
	end

	return config[self._resetTimes + 1]
end

function EliteStagePoint:getPointDetailViewName()
	return "ElitePointDetailView"
end
