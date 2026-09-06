-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/config/XiuNuoBrotherhoodConfig.lua

module("logic.extensions.xiunuobrotherhood.config.XiuNuoBrotherhoodConfig", package.seeall)

local XiuNuoBrotherhoodConfig = class("XiuNuoBrotherhoodConfig", BaseConfig)

function XiuNuoBrotherhoodConfig:onInit()
	XiuNuoBrotherhoodConfig.super.onInit(self)
end

function XiuNuoBrotherhoodConfig:getNames()
	return {
		"xiu_nuo_brotherhood_activity",
		"xiu_nuo_brotherhood_stage",
		"xiu_nuo_brotherhood_boss_plan",
		"xiu_nuo_brotherhood_buff_type",
		"xiu_nuo_brotherhood_buff",
		"xiu_nuo_brotherhood_enemy",
		"xiu_nuo_brotherhood_creeps",
		"xiu_nuo_brotherhood_sign_in_buff"
	}
end

function XiuNuoBrotherhoodConfig:handleConfig(name, content)
	if name == "xiu_nuo_brotherhood_activity" then
		self._xiu_nuo_brotherhood_activity = content
	elseif name == "xiu_nuo_brotherhood_stage" then
		self._xiu_nuo_brotherhood_stage = content
	elseif name == "xiu_nuo_brotherhood_boss_plan" then
		self._xiu_nuo_brotherhood_boss_plan = content
	elseif name == "xiu_nuo_brotherhood_buff_type" then
		self._xiu_nuo_brotherhood_buff_type = content
	elseif name == "xiu_nuo_brotherhood_buff" then
		self._xiu_nuo_brotherhood_buff = content
	elseif name == "xiu_nuo_brotherhood_enemy" then
		self._xiu_nuo_brotherhood_enemy = content
	elseif name == "xiu_nuo_brotherhood_creeps" then
		self._xiu_nuo_brotherhood_creeps = content
	elseif name == "xiu_nuo_brotherhood_sign_in_buff" then
		self._xiu_nuo_brotherhood_sign_in_buff = content
	end
end

function XiuNuoBrotherhoodConfig:getActivityCfg(activityId)
	return self._xiu_nuo_brotherhood_activity[activityId]
end

function XiuNuoBrotherhoodConfig:getFirstActivityId()
	return self._xiu_nuo_brotherhood_activity.dataList[1].activityId
end

function XiuNuoBrotherhoodConfig:getStageCfgs(activityId)
	return self._xiu_nuo_brotherhood_stage[activityId]
end

function XiuNuoBrotherhoodConfig:getStageCfg(activityId, stageId)
	return self._xiu_nuo_brotherhood_stage[activityId][stageId]
end

function XiuNuoBrotherhoodConfig:getBossPlanCfg(planId, bossId)
	return self._xiu_nuo_brotherhood_boss_plan[planId][bossId]
end

function XiuNuoBrotherhoodConfig:getBossPlanCfgs(planId)
	return self._xiu_nuo_brotherhood_boss_plan[planId]
end

function XiuNuoBrotherhoodConfig:getEnemyTeam(creepsMasterId)
	return self._xiu_nuo_brotherhood_enemy[creepsMasterId]
end

function XiuNuoBrotherhoodConfig:getEnemyCreeosCfg(creepsMasterId)
	return self._xiu_nuo_brotherhood_creeps[creepsMasterId]
end

function XiuNuoBrotherhoodConfig:getBuffTypeCfg(buffType, lv)
	return self._xiu_nuo_brotherhood_buff_type[buffType][lv]
end

function XiuNuoBrotherhoodConfig:getBuff(buffId)
	return self._xiu_nuo_brotherhood_buff[buffId]
end

function XiuNuoBrotherhoodConfig:getSignBuffCfg(activityId, level)
	return self._xiu_nuo_brotherhood_sign_in_buff[activityId][level]
end

XiuNuoBrotherhoodConfig.instance = XiuNuoBrotherhoodConfig.New()

return XiuNuoBrotherhoodConfig
