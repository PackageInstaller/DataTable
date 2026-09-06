-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/config/PeakTowerConfig.lua

module("logic.extensions.peaktower.config.PeakTowerConfig", package.seeall)

local PeakTowerConfig = class("PeakTowerConfig", BaseConfig)

function PeakTowerConfig:onInit()
	PeakTowerConfig.super.onInit(self)
end

function PeakTowerConfig:getNames()
	return {
		"peak_tower_activity",
		"peak_tower_alive_num_score",
		"peak_tower_circle_score",
		"peak_tower_creeps",
		"peak_tower_pollute_buff",
		"peak_tower_basic_progress",
		"peak_tower_master",
		"peak_tower_support_pet",
		"peak_tower_rank_prize",
		"peak_tower_legend_floor",
		"peak_tower_legend_progress",
		"peak_tower_basic_floor",
		"peak_tower_verify_race_plan",
		"peak_tower_verify_race_week",
		"peak_tower_stage"
	}
end

function PeakTowerConfig:handleConfig(name, content)
	if name == "peak_tower_activity" then
		self._peak_tower_activity = content
	elseif name == "peak_tower_alive_num_score" then
		self._peak_tower_alive_num_score = content
	elseif name == "peak_tower_circle_score" then
		self._peak_tower_circle_score = content
	elseif name == "peak_tower_creeps" then
		self._peak_tower_creeps = content
	elseif name == "peak_tower_pollute_buff" then
		self._peak_tower_pollute_buff = content
	elseif name == "peak_tower_basic_progress" then
		self._peak_tower_basic_progress = content
	elseif name == "peak_tower_master" then
		self._peak_tower_master = content
	elseif name == "peak_tower_support_pet" then
		self._peak_tower_support_pet = content
	elseif name == "peak_tower_rank_prize" then
		self._peak_tower_rank_prize = content
	elseif name == "peak_tower_legend_floor" then
		self._peak_tower_legend_floor = content
	elseif name == "peak_tower_legend_progress" then
		self._peak_tower_legend_progress = content
	elseif name == "peak_tower_basic_floor" then
		self._peak_tower_basic_floor = content
	elseif name == "peak_tower_verify_race_plan" then
		self._peak_tower_verify_race_plan = content
	elseif name == "peak_tower_verify_race_week" then
		self._peak_tower_verify_race_week = content
	elseif name == "peak_tower_stage" then
		self._peak_tower_stage = content
	end
end

function PeakTowerConfig:getActivityCfg(activityId)
	return self._peak_tower_activity[activityId]
end

function PeakTowerConfig:getBasicFloorCfgs(activityId, weekId)
	if self._peak_tower_basic_floor[activityId] then
		return self._peak_tower_basic_floor[activityId][weekId]
	end
end

function PeakTowerConfig:getBasicFloorCfg(activityId, weekId, floorId)
	if self._peak_tower_basic_floor[activityId] and self._peak_tower_basic_floor[activityId][weekId] then
		return self._peak_tower_basic_floor[activityId][weekId][floorId]
	end
end

function PeakTowerConfig:getBasicStageCfgs(activityId, weekId, floorId)
	local floorCfg = self:getBasicFloorCfg(activityId, weekId, floorId)

	if floorCfg then
		return self._peak_tower_stage[floorCfg.stagePlan]
	end
end

function PeakTowerConfig:getBasicStageCfg(activityId, weekId, floorId, stageId)
	local floorCfg = self:getBasicFloorCfg(activityId, weekId, floorId)

	if floorCfg and self._peak_tower_stage[floorCfg.stagePlan] then
		return self._peak_tower_stage[floorCfg.stagePlan][stageId]
	end
end

function PeakTowerConfig:getLegendFloorCfgs(activityId, weekId)
	if self._peak_tower_legend_floor[activityId] then
		return self._peak_tower_legend_floor[activityId][weekId]
	end
end

function PeakTowerConfig:getStageCfgs(stagePlan)
	return self._peak_tower_stage[stagePlan]
end

function PeakTowerConfig:getLegendFloorCfg(activityId, weekId, floorId)
	if self._peak_tower_legend_floor[activityId] and self._peak_tower_legend_floor[activityId][weekId] then
		return self._peak_tower_legend_floor[activityId][weekId][floorId]
	end
end

function PeakTowerConfig:getLegendStageCfgs(activityId, weekId, floorId)
	local floorCfg = self:getLegendFloorCfg(activityId, weekId, floorId)

	if floorCfg then
		return self._peak_tower_stage[floorCfg.stagePlan]
	end
end

function PeakTowerConfig:getLegendStageCfg(activityId, weekId, floorId, stageId)
	local floorCfg = self:getLegendFloorCfg(activityId, weekId, floorId)

	if floorCfg and self._peak_tower_stage[floorCfg.stagePlan] then
		return self._peak_tower_stage[floorCfg.stagePlan][stageId]
	end
end

function PeakTowerConfig:getAliveNumScoreCfgs(activityId)
	return self._peak_tower_alive_num_score[activityId]
end

function PeakTowerConfig:getCircleNumScoreCfgs(activityId)
	return self._peak_tower_circle_score[activityId]
end

function PeakTowerConfig:getCreepsCfg(creepsMasterId)
	return self._peak_tower_creeps[creepsMasterId]
end

function PeakTowerConfig:getTeamCfg(creepsMasterId)
	return self._peak_tower_master[creepsMasterId]
end

function PeakTowerConfig:getBasicProgressPrizeCfgs(activityId, weekId)
	if self._peak_tower_basic_progress[activityId] then
		return self._peak_tower_basic_progress[activityId][weekId]
	end
end

function PeakTowerConfig:getLegendProgressPrizeCfgs(activityId, weekId)
	if self._peak_tower_legend_progress[activityId] then
		return self._peak_tower_legend_progress[activityId][weekId]
	end
end

function PeakTowerConfig:getBuffCfg(activityId, buffId)
	if self._peak_tower_pollute_buff[activityId] then
		return self._peak_tower_pollute_buff[activityId][buffId]
	end
end

function PeakTowerConfig:getVerifyWeekCfg(activityId, week)
	if self._peak_tower_verify_race_week[activityId] then
		return self._peak_tower_verify_race_week[activityId][week]
	end
end

function PeakTowerConfig:getVerifyPlanCfg(verifyRacePlanId)
	return self._peak_tower_verify_race_plan[verifyRacePlanId]
end

function PeakTowerConfig:getSupportPetCfgs(activityId)
	return self._peak_tower_support_pet[activityId]
end

function PeakTowerConfig:getLegendRankPrizeCfgs(activityId, weekId)
	if self._peak_tower_rank_prize[activityId] then
		return self._peak_tower_rank_prize[activityId][weekId]
	end
end

PeakTowerConfig.instance = PeakTowerConfig.New()

return PeakTowerConfig
