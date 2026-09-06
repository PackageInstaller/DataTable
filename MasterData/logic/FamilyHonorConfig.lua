-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/config/FamilyHonorConfig.lua

module("logic.extensions.newfamily.config.FamilyHonorConfig", package.seeall)

local FamilyHonorConfig = class("FamilyHonorConfig", BaseConfig)

function FamilyHonorConfig:onInit()
	FamilyHonorConfig.super.onInit(self)

	self._familyMedalCfgs = nil
	self._medalSourceCfgs = nil
	self._familyCommonCfgs = nil
	self._taskLevelCfgs = nil
	self._taskInfoCfgs = nil
	self._taskTypeList = nil
end

function FamilyHonorConfig:getNames()
	return {
		"family_medal",
		"family_medal_source",
		"family_medal_common",
		"family_task_level",
		"family_task"
	}
end

function FamilyHonorConfig:handleConfig(name, content)
	if name == "family_medal" then
		self._familyMedalCfgs = content
	elseif name == "family_medal_source" then
		self._medalSourceCfgs = content
	elseif name == "family_medal_common" then
		self._familyCommonCfgs = content
	elseif name == "family_task_level" then
		self._taskLevelCfgs = content
	elseif name == "family_task" then
		self:_setFamilyTaskIdsList(content)
	end
end

function FamilyHonorConfig:getAllFamilyMedalCfgs()
	return self._familyMedalCfgs or {}
end

function FamilyHonorConfig:getFamilyMedalCfg(defineId)
	defineId = checknumber(defineId)

	if defineId <= 0 or self._familyMedalCfgs == nil then
		return
	end

	return self._familyMedalCfgs[defineId]
end

function FamilyHonorConfig:getFamilyMedalSourceCfg(sourceId)
	defineId = checknumber(sourceId)

	if sourceId <= 0 or self._medalSourceCfgs == nil then
		return
	end

	return self._medalSourceCfgs[sourceId]
end

function FamilyHonorConfig:getFamilyCommonCfg(strKey)
	if string.nilorempty(strKey) or self._familyCommonCfgs[strKey] == nil then
		return
	end

	return self._familyCommonCfgs[strKey].value
end

function FamilyHonorConfig:_setFamilyTaskIdsList(data)
	self._taskInfoCfgs = data
	self._taskTypeList = {}

	for _, cfg in pairs(data.dataList or {}) do
		if cfg and checknumber(cfg.id) > 0 then
			if self._taskTypeList[cfg.type] == nil then
				self._taskTypeList[cfg.type] = {}
			end

			table.insert(self._taskTypeList[cfg.type], cfg.id)
		end
	end

	for _, list in pairs(self._taskTypeList or {}) do
		if list and #list > 0 then
			table.sort(list, function(a, b)
				return a < b
			end)
		end
	end
end

function FamilyHonorConfig:getAllFamilyTaskLevelCfgs()
	return self._taskLevelCfgs or {}
end

function FamilyHonorConfig:getFamilyTaskLevelCfg(level)
	if self._taskLevelCfgs == nil then
		return
	end

	return self._taskLevelCfgs[level]
end

function FamilyHonorConfig:getFamilyTaskInfoCfg(taskId)
	taskId = checknumber(taskId)

	if taskId <= 0 or self._taskInfoCfgs == nil then
		return
	end

	return self._taskInfoCfgs[taskId]
end

function FamilyHonorConfig:getFamilyTaskIdsList()
	return self._taskTypeList or {}
end

FamilyHonorConfig.instance = FamilyHonorConfig.New()

return FamilyHonorConfig
