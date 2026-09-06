-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/config/LTDaJiaoConfig.lua

module("logic.extensions.luotiandajiao.config.LTDaJiaoConfig", package.seeall)

local LTDaJiaoConfig = class("LTDaJiaoConfig", BaseConfig)

function LTDaJiaoConfig:onInit()
	LTDaJiaoConfig.super.onInit(self)

	self._commonCfg = nil
	self._groupChallengeCfg = nil
	self._creepsCfg = nil
	self._buffDefineCfg = nil
	self._groupCfg = nil
end

function LTDaJiaoConfig:getNames()
	return {
		"luo_tian_da_jiao_common",
		"luo_tian_da_jiao_group_challenge",
		"luo_tian_da_jiao_creeps",
		"luo_tian_da_jiao_buff_define",
		"luo_tian_da_jiao_group"
	}
end

function LTDaJiaoConfig:handleConfig(name, content)
	if name == "luo_tian_da_jiao_common" then
		self._commonCfg = content
	elseif name == "luo_tian_da_jiao_group_challenge" then
		self._groupChallengeCfg = content
	elseif name == "luo_tian_da_jiao_creeps" then
		self._creepsCfg = content
	elseif name == "luo_tian_da_jiao_buff_define" then
		self._buffDefineCfg = content
	elseif name == "luo_tian_da_jiao_group" then
		self._groupCfg = content
	end
end

function LTDaJiaoConfig:getCommonCfg(id)
	return self._commonCfg[id]
end

function LTDaJiaoConfig:getGroupChallengeCfg(planId, group, stage)
	if self._groupChallengeCfg[planId] and self._groupChallengeCfg[planId][group] and self._groupChallengeCfg[planId][group][stage] then
		return self._groupChallengeCfg[planId][group][stage]
	end

	return nil
end

function LTDaJiaoConfig:getCreepCfgs(creepsMasterId)
	return self._creepsCfg[creepsMasterId]
end

function LTDaJiaoConfig:getBuffCfgs(buffPlanId)
	return self._buffDefineCfg[buffPlanId]
end

function LTDaJiaoConfig:getBuffCfgById(buffPlanId, level)
	if self._buffDefineCfg[buffPlanId] then
		return self._buffDefineCfg[buffPlanId][level]
	end
end

function LTDaJiaoConfig:getGroupCfgs(groupPlanId)
	return self._groupCfg[groupPlanId]
end

function LTDaJiaoConfig:getGroupCfgById(groupPlanId, group)
	if self._groupCfg[groupPlanId] then
		return self._groupCfg[groupPlanId][group]
	end

	return nil
end

LTDaJiaoConfig.instance = LTDaJiaoConfig.New()

return LTDaJiaoConfig
