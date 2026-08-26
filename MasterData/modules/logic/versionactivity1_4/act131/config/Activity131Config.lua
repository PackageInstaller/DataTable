-- chunkname: @modules/logic/versionactivity1_4/act131/config/Activity131Config.lua

module("modules.logic.versionactivity1_4.act131.config.Activity131Config", package.seeall)

local Activity131Config = class("Activity131Config", BaseConfig)

function Activity131Config:ctor()
	self._act131EpisodeConfig = nil
	self._act131ElementConfig = nil
	self._act131DialogConfig = nil
	self._act131DialogList = nil
	self._act131TaskConfig = nil
end

function Activity131Config:reqConfigNames()
	return {
		"activity131_episode",
		"activity131_element",
		"activity131_dialog",
		"activity131_task"
	}
end

function Activity131Config:onConfigLoaded(configName, configTable)
	if configName == "activity131_episode" then
		self._act131EpisodeConfig = configTable
	elseif configName == "activity131_element" then
		self._act131ElementConfig = configTable
	elseif configName == "activity131_dialog" then
		self._act131DialogConfig = configTable

		self:_initDialog()
	elseif configName == "activity131_task" then
		self._act131TaskConfig = configTable
	end
end

function Activity131Config:getActivity131EpisodeCos(actId)
	return self._act131EpisodeConfig.configDict[actId]
end

function Activity131Config:getActivity131EpisodeCo(actId, id)
	return self._act131EpisodeConfig.configDict[actId][id]
end

function Activity131Config:getActivity131ElementCo(actId, id)
	return self._act131ElementConfig.configDict[actId][id]
end

function Activity131Config:getActivity131DialogCo(dialogId, stepId)
	return self._act131DialogConfig.configDict[dialogId][stepId]
end

function Activity131Config:getActivity131DialogGroup(dialogId)
	return self._act131DialogConfig.configDict[dialogId]
end

function Activity131Config:_initDialog()
	self._act131DialogList = {}

	local sectionId
	local defaultId = "0"

	for i, v in ipairs(self._act131DialogConfig.configList) do
		local group = self._act131DialogList[v.id]

		if not group then
			group = {
				optionParamList = {}
			}
			sectionId = defaultId
			self._act131DialogList[v.id] = group
		end

		if not string.nilorempty(v.option_param) then
			table.insert(group.optionParamList, tonumber(v.option_param))
		end

		if v.type == "selector" then
			sectionId = v.param
			group[sectionId] = group[v.param] or {}
			group[sectionId].type = v.type
			group[sectionId].option_param = v.option_param
		elseif v.type == "selectorend" then
			sectionId = defaultId
		elseif v.type == "random" then
			local sectionId = v.param

			group[sectionId] = group[sectionId] or {}
			group[sectionId].type = v.type
			group[sectionId].option_param = v.option_param

			table.insert(group[sectionId], v)
		else
			group[sectionId] = group[sectionId] or {}

			table.insert(group[sectionId], v)
		end
	end
end

function Activity131Config:getDialog(groupId, sectionId)
	local group = self._act131DialogList[groupId]

	return group and group[sectionId]
end

function Activity131Config:getOptionParamList(groupId)
	local group = self._act131DialogList[groupId]

	return group and group.optionParamList
end

function Activity131Config:getActivity131TaskCo(id)
	return self._act131TaskConfig.configDict[id]
end

function Activity131Config:getTaskByActId(actId)
	local list = {}

	for _, co in pairs(self._act131TaskConfig.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

Activity131Config.instance = Activity131Config.New()

return Activity131Config
