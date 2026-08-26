-- chunkname: @modules/logic/versionactivity1_6/act148/config/Activity148Config.lua

module("modules.logic.versionactivity1_6.act148.config.Activity148Config", package.seeall)

local Activity148Config = class("Activity148Config", BaseConfig)

function Activity148Config:ctor()
	self._cfgDict = {}
	self._activityConstDict = {}
	self._skillTypeCfgDict = {}
end

function Activity148Config:reqConfigNames()
	return {
		"activity148",
		"activity148_const",
		"activity148_skill_type"
	}
end

function Activity148Config:onConfigLoaded(configName, configTable)
	if configName == "activity148" then
		self:initAct148CfgDict(configTable)
	elseif configName == "activity148_const" then
		self._activityConstDict = configTable.configDict
	elseif configName == "activity148_skill_type" then
		self._skillTypeCfgDict = configTable.configDict
	end
end

function Activity148Config:initAct148CfgDict(configTable)
	self._cfgDict = configTable.configDict
	self._skillTypeDict = {}

	for _, cfg in pairs(self._cfgDict) do
		local type = cfg.type

		self._skillTypeDict[type] = self._skillTypeDict[type] or {}

		local lv = cfg.level
		local skillTypeDict = self._skillTypeDict[type]

		skillTypeDict[lv] = cfg
	end
end

function Activity148Config:getAct148Cfg(id)
	return self._cfgDict[id]
end

function Activity148Config:getAct148CfgByTypeLv(type, lv)
	if not lv or not type then
		return nil
	end

	local skillLvDict = self._skillTypeDict[type]

	return skillLvDict and skillLvDict[lv]
end

function Activity148Config:getAct148ConstValue(activityId, id)
	local cfg = self._activityConstDict[id][activityId]

	return cfg.value
end

function Activity148Config:getAct148CfgDictByType(type)
	if not type then
		return nil
	end

	return self._skillTypeDict[type]
end

function Activity148Config:getAct148SkillTypeCfg(type)
	if not type then
		return nil
	end

	return self._skillTypeCfgDict[type]
end

function Activity148Config:getAct148SkillPointCost(type, lv)
	local totalCost = 0

	if lv == 0 then
		return totalCost
	end

	local skillTypeList = self._skillTypeDict[type]

	if not skillTypeList then
		return totalCost
	end

	for i = 1, lv do
		local skillCfg = skillTypeList[i]
		local costStr = skillCfg.cost
		local attribute = string.splitToNumber(costStr, "#")

		totalCost = totalCost + attribute[3]
	end

	return totalCost
end

Activity148Config.instance = Activity148Config.New()

return Activity148Config
