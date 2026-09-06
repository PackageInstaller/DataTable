-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/config/HolyStripeCopyConfig.lua

module("logic.extensions.holystripecopy.config.HolyStripeCopyConfig", package.seeall)

local HolyStripeCopyConfig = class("HolyStripeCopyConfig", BaseConfig)

function HolyStripeCopyConfig:onInit()
	HolyStripeCopyConfig.super.onInit(self)
end

function HolyStripeCopyConfig:getNames()
	return {
		"ling_wen_tab",
		"ling_wen_common",
		"ling_wen_stage",
		"ling_wen_team",
		"ling_wen_creeps"
	}
end

function HolyStripeCopyConfig:handleConfig(name, content)
	if name == "ling_wen_tab" then
		self._tabCfgs = content
	elseif name == "ling_wen_common" then
		self._commonCfgs = content
	elseif name == "ling_wen_stage" then
		self._stageCfgs = content
		self._stageCfgHash = {}

		for k, v in ipairs(content.dataList) do
			self._stageCfgHash[v.groupId] = v
		end
	elseif name == "ling_wen_team" then
		self._creepsCfgs = content
	elseif name == "ling_wen_creeps" then
		self._creepsMasterCfgs = content
	end
end

function HolyStripeCopyConfig:getTabCfgByTabId(tabId)
	return self._tabCfgs[tabId]
end

function HolyStripeCopyConfig:getTabCfgs()
	return self._tabCfgs
end

function HolyStripeCopyConfig:getCommonValue(key)
	if self._commonCfgs[key] then
		return self._commonCfgs[key].value
	end
end

function HolyStripeCopyConfig:getStageCfgsByTabId(tabId)
	return self._stageCfgs[tabId]
end

function HolyStripeCopyConfig:getStageCfg(tabId, stageId)
	return self._stageCfgs[tabId][stageId]
end

function HolyStripeCopyConfig:getStageCfgByGroupId(groupId)
	return self._stageCfgHash[groupId]
end

function HolyStripeCopyConfig:getCreepCfgsByPlanId(planId)
	return self._creepsCfgs[planId]
end

function HolyStripeCopyConfig:getCreepCfg(planId, sortId)
	return self._creepsCfgs[planId][sortId]
end

function HolyStripeCopyConfig:getCreepMonsterCfgs(creepId)
	return self._creepsMasterCfgs[creepId]
end

HolyStripeCopyConfig.instance = HolyStripeCopyConfig.New()

return HolyStripeCopyConfig
