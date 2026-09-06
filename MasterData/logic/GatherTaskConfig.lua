-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/config/GatherTaskConfig.lua

module("logic.extensions.gathertask.config.GatherTaskConfig", package.seeall)

local GatherTaskConfig = class("GatherTaskConfig", BaseConfig)

function GatherTaskConfig:onInit()
	GatherTaskConfig.super.onInit(self)
end

function GatherTaskConfig:getNames()
	return {
		"christmas_gather_activity",
		"christmas_gather_material",
		"christmas_gather_scene",
		"christmas_gather_progress_prize",
		"christmas_gather_common"
	}
end

function GatherTaskConfig:handleConfig(name, content)
	if name == "christmas_gather_activity" then
		self.christmas_gather_activityCfg = content
	elseif name == "christmas_gather_material" then
		self.christmas_gather_materialCfg = content
	elseif name == "christmas_gather_scene" then
		self.christmas_gather_scenefCfg = content
	elseif name == "christmas_gather_progress_prize" then
		self.christmas_gather_progress_prizeCfg = content
	elseif name == "christmas_gather_common" then
		self.christmas_gather_commonCfg = content
	end
end

function GatherTaskConfig:getCommonValue(id)
	local obj = self.christmas_gather_commonCfg[id]

	if obj then
		return obj.value
	end

	return ""
end

function GatherTaskConfig:getActivityCfgById(id)
	return self.christmas_gather_activityCfg[id]
end

function GatherTaskConfig:getMaterialCfgList(plan)
	return self.christmas_gather_materialCfg[plan]
end

function GatherTaskConfig:getMaterialCfgById(plan, id)
	return self.christmas_gather_materialCfg[plan][id]
end

function GatherTaskConfig:getNpcCfgList(plan)
	return self.christmas_gather_scenefCfg[plan]
end

function GatherTaskConfig:getNpcCfgById(group, idx)
	return self.christmas_gather_scenefCfg[group][idx]
end

function GatherTaskConfig:getPrizeList(plan)
	return self.christmas_gather_progress_prizeCfg[plan]
end

function GatherTaskConfig:getPrizeCfgById(plan, idx)
	return self.christmas_gather_progress_prizeCfg[plan][idx]
end

GatherTaskConfig.instance = GatherTaskConfig.New()

return GatherTaskConfig
