-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/config/DivineWeiLeiTaClgConfig.lua

module("logic.extensions.divineweileitaclg.config.DivineWeiLeiTaClgConfig", package.seeall)

local DivineWeiLeiTaClgConfig = class("DivineWeiLeiTaClgConfig", BaseConfig)

function DivineWeiLeiTaClgConfig:getNames()
	return {
		"divine_wei_lei_ta_clg_normal_desc",
		"divine_wei_lei_ta_clg_activity",
		"divine_wei_lei_ta_clg_creeps",
		"divine_wei_lei_ta_clg_normal_prize",
		"divine_wei_lei_ta_clg_extreme_stage",
		"divine_wei_lei_ta_clg_team",
		"divine_wei_lei_ta_clg_normal_damage"
	}
end

function DivineWeiLeiTaClgConfig:handleConfig(name, content)
	if name == "divine_wei_lei_ta_clg_normal_desc" then
		self._divine_wei_lei_ta_clg_normal_desc = content
	elseif name == "divine_wei_lei_ta_clg_activity" then
		self._divine_wei_lei_ta_clg_activity = content
	elseif name == "divine_wei_lei_ta_clg_creeps" then
		self._divine_wei_lei_ta_clg_creeps = content
	elseif name == "divine_wei_lei_ta_clg_normal_prize" then
		self._divine_wei_lei_ta_clg_normal_prize = content
	elseif name == "divine_wei_lei_ta_clg_extreme_stage" then
		self._divine_wei_lei_ta_clg_extreme_stage = content
	elseif name == "divine_wei_lei_ta_clg_team" then
		self._divine_wei_lei_ta_clg_team = content
	elseif name == "divine_wei_lei_ta_clg_normal_damage" then
		self._divine_wei_lei_ta_clg_normal_damage = content

		self:handleNormalDamage(content)
	end
end

function DivineWeiLeiTaClgConfig:getActivityCfg(activityId)
	return self._divine_wei_lei_ta_clg_activity[activityId]
end

function DivineWeiLeiTaClgConfig:getExtremeStageCfgs(activityId)
	return self._divine_wei_lei_ta_clg_extreme_stage[activityId]
end

function DivineWeiLeiTaClgConfig:getExtremeStageCfg(activityId, stageId)
	return self._divine_wei_lei_ta_clg_extreme_stage[activityId][stageId]
end

function DivineWeiLeiTaClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_wei_lei_ta_clg_team[creepsMasterId]
end

function DivineWeiLeiTaClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_wei_lei_ta_clg_creeps[creepsMasterId]
end

function DivineWeiLeiTaClgConfig:getRewardProgressListCfgs(activityId)
	return self._divine_wei_lei_ta_clg_normal_prize[activityId]
end

function DivineWeiLeiTaClgConfig:getNormalPrizeCfg(activityId, prizeId)
	return self._divine_wei_lei_ta_clg_normal_prize[activityId][prizeId]
end

function DivineWeiLeiTaClgConfig:getDamageCfgs(activityId)
	return self._divine_wei_lei_ta_clg_normal_damage[activityId]
end

function DivineWeiLeiTaClgConfig:getNormalDnamgeCfg(activityId)
	return self._normalDamageCfg[activityId]
end

function DivineWeiLeiTaClgConfig:handleNormalDamage(content)
	self._normalDamageCfg = {}

	for i, v in ipairs(content.dataList) do
		self._normalDamageCfg[v.activityId] = self._normalDamageCfg[v.activityId] or {}

		table.insert(self._normalDamageCfg[v.activityId], v)
	end
end

function DivineWeiLeiTaClgConfig:getNormalDesc(creepsMasterId)
	return self._divine_wei_lei_ta_clg_normal_desc[creepsMasterId]
end

DivineWeiLeiTaClgConfig.instance = DivineWeiLeiTaClgConfig.New()

return DivineWeiLeiTaClgConfig
