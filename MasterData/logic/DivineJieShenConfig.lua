-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/config/DivineJieShenConfig.lua

module("logic.extensions.DivineJieShen.config.DivineJieShenConfig", package.seeall)

local DivineJieShenConfig = class("DivineJieShenConfig", BaseConfig)

function DivineJieShenConfig:onInit()
	DivineJieShenConfig.super.onInit(self)
end

function DivineJieShenConfig:getNames()
	return {
		"divine_jieshen_clg_activity",
		"divine_jieshen_clg_common",
		"divine_jieshen_clg_extreme_tower",
		"divine_jieshen_clg_extreme_stage",
		"divine_jieshen_clg_nornal_stage",
		"divine_jieshen_clg_normal_buff",
		"divine_jieshen_clg_redraw_cost",
		"divine_jieshen_clg_normal_trial_random_plan",
		"divine_jieshen_clg_monster",
		"divine_jieshen_clg_creeps"
	}
end

function DivineJieShenConfig:handleConfig(name, content)
	if name == "divine_jieshen_clg_activity" then
		self.divine_jieshen_clg_activity = content
		self._cfg = {}

		for i, v in pairs(content.dataList) do
			self._cfg[v.trialRandomPlanId] = v
		end
	elseif name == "divine_jieshen_clg_common" then
		self.divine_jieshen_clg_common = content
	elseif name == "divine_jieshen_clg_extreme_tower" then
		self.divine_jieshen_clg_extreme_tower = content
	elseif name == "divine_jieshen_clg_extreme_stage" then
		self.divine_jieshen_clg_extreme_stage = content
	elseif name == "divine_jieshen_clg_nornal_stage" then
		self.divine_jieshen_clg_nornal_stage = content
	elseif name == "divine_jieshen_clg_normal_buff" then
		self.divine_jieshen_clg_normal_buff = content
	elseif name == "divine_jieshen_clg_redraw_cost" then
		self.divine_jieshen_clg_redraw_cost = content
	elseif name == "divine_jieshen_clg_normal_trial_random_plan" then
		self.divine_jieshen_clg_normal_trial_random_plan = content
	elseif name == "divine_jieshen_clg_monster" then
		self.divine_jieshen_clg_monster = content
	elseif name == "divine_jieshen_clg_creeps" then
		self.divine_jieshen_clg_creeps = content
	end
end

function DivineJieShenConfig:getActData(activityId)
	return self.divine_jieshen_clg_activity[activityId]
end

function DivineJieShenConfig:getCommonValue(activityId, key, isToNumber)
	local data = self:getActData(activityId)

	if data then
		if not data.comPlanId then
			local comPlanId = 0
			local comData = self.divine_jieshen_clg_common[comPlanId]

			if comData then
				if isToNumber then
					return checknumber(comData[key])
				else
					return comData[key]
				end
			end
		end
	end
end

function DivineJieShenConfig:getExtTowerData(activityId)
	return self.divine_jieshen_clg_extreme_tower[activityId]
end

function DivineJieShenConfig:getExtOnlyTowerData(activityId, towerId)
	if self.divine_jieshen_clg_extreme_tower[activityId] then
		return self.divine_jieshen_clg_extreme_tower[activityId][towerId]
	end
end

function DivineJieShenConfig:getExtStageCfg(activityId)
	return self.divine_jieshen_clg_extreme_stage[activityId]
end

function DivineJieShenConfig:getExtStageDatas(activityId, towerId)
	if self.divine_jieshen_clg_extreme_stage[activityId] then
		return self.divine_jieshen_clg_extreme_stage[activityId][towerId]
	end
end

function DivineJieShenConfig:getExtStageData(activityId, towerId, stageId)
	if self.divine_jieshen_clg_extreme_stage[activityId] and self.divine_jieshen_clg_extreme_stage[activityId][towerId] then
		return self.divine_jieshen_clg_extreme_stage[activityId][towerId][stageId]
	end
end

function DivineJieShenConfig:getNorStageCfg(activityId)
	return self.divine_jieshen_clg_nornal_stage[activityId]
end

function DivineJieShenConfig:getNorStageData(activityId, stageId)
	if self.divine_jieshen_clg_nornal_stage[activityId] then
		return self.divine_jieshen_clg_nornal_stage[activityId][stageId]
	end
end

function DivineJieShenConfig:getNorBuffCfg(activityId)
	return self.divine_jieshen_clg_normal_buff[activityId]
end

function DivineJieShenConfig:getNorBuffData(activityId, passStageCount)
	local data

	if self.divine_jieshen_clg_normal_buff[activityId] then
		data = self.divine_jieshen_clg_normal_buff[activityId][passStageCount]
	end

	if data == nil then
		local cfg = self:getNorBuffCfg(activityId)

		if cfg then
			local max = -1

			for i, v in pairs(cfg) do
				local count = v.passStageCount

				if max < count and count <= passStageCount then
					max = count
					data = v
				end
			end
		end
	end

	return data
end

function DivineJieShenConfig:getRedrawCostCfg(activityId)
	local actData = self:getActData(activityId)

	if actData then
		if not actData.redrawPlanId then
			local redrawPlanId = 0

			return self.divine_jieshen_clg_redraw_cost[redrawPlanId]
		end
	end
end

function DivineJieShenConfig:getRedrawCostData(activityId, redrawTimes)
	local data
	local cfg = self:getRedrawCostCfg(activityId)

	if cfg then
		data = cfg[redrawTimes]
	end

	if data == nil and cfg then
		local max = -1

		for i, v in pairs(cfg) do
			local cur = v.redrawTimes

			if max < cur and cur <= redrawTimes then
				max = cur
				data = v
			end
		end
	end

	return data
end

function DivineJieShenConfig:getRandomPlanCfg(activityId)
	local actData = self:getActData(activityId)

	if actData then
		if not actData.trialRandomPlanId then
			local trialRandomPlanId = 0

			return self.divine_jieshen_clg_normal_trial_random_plan[trialRandomPlanId]
		end
	end
end

function DivineJieShenConfig:getRandomPlanData(activityId, trialMode)
	local data
	local cfg = self:getRandomPlanCfg(activityId)

	return (cfg or nil) and cfg[trialMode]
end

function DivineJieShenConfig:getClgMonsterData(creepsMasterId)
	return self.divine_jieshen_clg_monster[creepsMasterId]
end

function DivineJieShenConfig:getClgCreepsCfg(creepsMasterId)
	return self.divine_jieshen_clg_creeps[creepsMasterId]
end

DivineJieShenConfig.instance = DivineJieShenConfig.New()

return DivineJieShenConfig
