-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/config/OriginaresmomConfig.lua

module("logic.extensions.originaresmom.config.OriginaresmomConfig", package.seeall)

local OriginaresmomConfig = class("OriginaresmomConfig", BaseConfig)

function OriginaresmomConfig:onInit()
	return
end

function OriginaresmomConfig:getNames()
	return {
		"origin_ares_mom_clg_buff_plan",
		"origin_ares_mom_clg_support_pet",
		"origin_ares_mom_clg_normal_stage",
		"origin_ares_mom_clg_monster",
		"origin_ares_mom_clg_creeps",
		"origin_ares_mom_clg_normal_prize",
		"origin_ares_mom_clg_activity",
		"origin_ares_mom_clg_extreme_stage"
	}
end

function OriginaresmomConfig:handleConfig(name, content)
	if name == "origin_ares_mom_clg_buff_plan" then
		self._origin_ares_mom_clg_buff_plan = content
	elseif name == "origin_ares_mom_clg_support_pet" then
		self._origin_ares_mom_clg_support_pet = content
	elseif name == "origin_ares_mom_clg_normal_stage" then
		self._origin_ares_mom_clg_normal_stage = content
	elseif name == "origin_ares_mom_clg_monster" then
		self._origin_ares_mom_clg_monster = content
	elseif name == "origin_ares_mom_clg_creeps" then
		self._origin_ares_mom_clg_creeps = content
	elseif name == "origin_ares_mom_clg_normal_prize" then
		self._origin_ares_mom_clg_normal_prize = content
	elseif name == "origin_ares_mom_clg_activity" then
		self._origin_ares_mom_clg_activity = content
	elseif name == "origin_ares_mom_clg_extreme_stage" then
		self._origin_ares_mom_clg_extreme_stage = content
	end
end

function OriginaresmomConfig:getActCfg(activityId)
	return self._origin_ares_mom_clg_activity[activityId]
end

function OriginaresmomConfig:getExtStageCfgs(activityId)
	return self._origin_ares_mom_clg_extreme_stage[activityId]
end

function OriginaresmomConfig:getExtStageCfg(activityId, stageId)
	return self._origin_ares_mom_clg_extreme_stage[activityId][stageId]
end

function OriginaresmomConfig:getNorStageCfgs(activityId)
	return self._origin_ares_mom_clg_normal_stage[activityId]
end

function OriginaresmomConfig:getNorStageCfg(activityId, stageId)
	return self._origin_ares_mom_clg_normal_stage[activityId][stageId]
end

function OriginaresmomConfig:getNorPrizeCfgs(activityId)
	return self._origin_ares_mom_clg_normal_prize[activityId]
end

function OriginaresmomConfig:getCreepsCfgs(creepsMasterId)
	return self._origin_ares_mom_clg_creeps[creepsMasterId]
end

function OriginaresmomConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_ares_mom_clg_monster[creepsMasterId]
end

function OriginaresmomConfig:getNorSupportPetsCfgs(activityId)
	return self._origin_ares_mom_clg_support_pet[activityId]
end

function OriginaresmomConfig:getBuffCfgs(energyAddBuffPlanId)
	return self._origin_ares_mom_clg_buff_plan[energyAddBuffPlanId]
end

function OriginaresmomConfig:getBuffDescByScore(activityId, score)
	local actCfg = self:getActCfg(activityId)
	local cfgs = self:getBuffCfgs(actCfg.energyAddBuffPlanId)
	local newCfgs = table.values(cfgs)

	table.sort(newCfgs, function(a, b)
		return a.startEnergy < b.startEnergy
	end)

	for i = #newCfgs, 1, -1 do
		if score >= newCfgs[i].startEnergy then
			return newCfgs[i].desc
		end
	end

	return "暂无效果"
end

OriginaresmomConfig.instance = OriginaresmomConfig.New()

return OriginaresmomConfig
