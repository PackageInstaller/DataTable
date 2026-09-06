-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/config/ProjectAshConfig.lua

module("logic.extensions.projectash.config.ProjectAshConfig", package.seeall)

local ProjectAshConfig = class("ProjectAshConfig", BaseConfig)

function ProjectAshConfig:onInit()
	ProjectAshConfig.super.onInit(self)

	self.project_ash = nil
	self.project_ash_cost_pan = nil
	self.project_ash_lottery = nil
	self.project_ash_buff_plan = nil
	self.project_ash_boss = nil
	self.project_ash_creeps = nil
	self.project_ash_support_pet = nil
	self.project_ash_progress_prize = nil
	self.project_ash_progress_value = nil
	self.project_ash_rank_prize = nil
end

function ProjectAshConfig:getNames()
	return {
		"project_ash",
		"project_ash_cost_pan",
		"project_ash_lottery",
		"project_ash_buff_plan",
		"project_ash_boss",
		"project_ash_creeps",
		"project_ash_support_pet",
		"project_ash_progress_prize",
		"project_ash_progress_value",
		"project_ash_rank_prize"
	}
end

function ProjectAshConfig:handleConfig(name, content)
	if name == "project_ash" then
		self.project_ash = content
	elseif name == "project_ash_cost_pan" then
		self.project_ash_cost_pan = content
	elseif name == "project_ash_lottery" then
		self.project_ash_lottery = content
	elseif name == "project_ash_buff_plan" then
		self.project_ash_buff_plan = content
	elseif name == "project_ash_boss" then
		self.project_ash_boss = content
	elseif name == "project_ash_creeps" then
		self.project_ash_creeps = content
	elseif name == "project_ash_support_pet" then
		self.project_ash_support_pet = content
	elseif name == "project_ash_progress_prize" then
		self.project_ash_progress_prize = content
	elseif name == "project_ash_progress_value" then
		self.project_ash_progress_value = content
	elseif name == "project_ash_rank_prize" then
		self.project_ash_rank_prize = content
	end
end

function ProjectAshConfig:getActivityCfg(activityId)
	return self.project_ash[activityId]
end

function ProjectAshConfig:getCostPanCfgList(costPlanId)
	return self.project_ash_cost_pan[costPlanId]
end

function ProjectAshConfig:getCostPanCfg(costPlanId, id)
	return self.project_ash_cost_pan[costPlanId] and self.project_ash_cost_pan[costPlanId][id]
end

function ProjectAshConfig:getLotteryCfgList(activityId)
	return self.project_ash_lottery[activityId]
end

function ProjectAshConfig:getShowLotteryCfgList(lotteryPlanId)
	local list = self.project_ash_lottery[lotteryPlanId]
	local targetList = {}

	for i, v in ipairs(list) do
		local isShow = v.isShow > 0

		if isShow then
			table.insert(targetList, v)
		end
	end

	return targetList
end

function ProjectAshConfig:getLotteryCfg(activityId, id)
	return self.project_ash_lottery[activityId] and self.project_ash_lottery[activityId][id]
end

function ProjectAshConfig:getBuffCfgList(buffPlanId)
	return self.project_ash_buff_plan[buffPlanId]
end

function ProjectAshConfig:getBuffCfg(buffPlanId, buffId)
	return self.project_ash_buff_plan[buffPlanId] and self.project_ash_buff_plan[buffPlanId][buffId]
end

function ProjectAshConfig:getBossCfg(creepsMasterId)
	return self.project_ash_boss[creepsMasterId]
end

function ProjectAshConfig:getCreepsCfg(creepsMasterId)
	return self.project_ash_creeps[creepsMasterId]
end

function ProjectAshConfig:getSupportPets(activityId)
	return self.project_ash_support_pet[activityId]
end

function ProjectAshConfig:getSupportPet(activityId, creepsId)
	return self.project_ash_support_pet[activityId] and self.project_ash_support_pet[activityId][creepsId]
end

function ProjectAshConfig:getProgressPrizeCfgList(planId)
	return self.project_ash_progress_prize[planId]
end

function ProjectAshConfig:getProgressPrizeCfg(planId, id)
	return self.project_ash_progress_prize[planId] and self.project_ash_progress_prize[planId][id]
end

function ProjectAshConfig:getProgressValueCfgList(progressPlanId)
	return self.project_ash_progress_value[progressPlanId]
end

function ProjectAshConfig:getRankPrizeCfgList(activityId)
	local list = {}

	for i, v in ipairs(self.project_ash_rank_prize.dataList) do
		if v.activityId == activityId then
			table.insert(list, v)
		end
	end

	return list
end

ProjectAshConfig.instance = ProjectAshConfig.New()

return ProjectAshConfig
