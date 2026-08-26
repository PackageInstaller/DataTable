-- chunkname: @modules/logic/versionactivity1_4/act130/config/Activity130Config.lua

module("modules.logic.versionactivity1_4.act130.config.Activity130Config", package.seeall)

local Activity130Config = class("Activity130Config", BaseConfig)

function Activity130Config:ctor()
	self._act130EpisodeConfig = nil
	self._act130DecryptConfig = nil
	self._act130OperGroupConfig = nil
	self._act130ElementConfig = nil
	self._act130DialogList = nil
	self._act130TaskConfig = nil
end

function Activity130Config:reqConfigNames()
	return {
		"activity130_episode",
		"activity130_decrypt",
		"activity130_oper_group",
		"activity130_element",
		"activity130_dialog",
		"activity130_task"
	}
end

function Activity130Config:onConfigLoaded(configName, configTable)
	if configName == "activity130_episode" then
		self._act130EpisodeConfig = configTable
	elseif configName == "activity130_decrypt" then
		self._act130DecryptConfig = configTable
	elseif configName == "activity130_oper_group" then
		self._act130OperGroupConfig = configTable
	elseif configName == "activity130_element" then
		self._act130ElementConfig = configTable
	elseif configName == "activity130_dialog" then
		self:_initDialog()
	elseif configName == "activity130_task" then
		self._act130TaskConfig = configTable
	end
end

function Activity130Config:getActivity130EpisodeCos(actId)
	return self._act130EpisodeConfig.configDict[actId]
end

function Activity130Config:getActivity130EpisodeCo(actId, id)
	return self._act130EpisodeConfig.configDict[actId][id]
end

function Activity130Config:getActivity130DecryptCos(actId)
	return self._act130DecryptConfig.configDict[actId]
end

function Activity130Config:getActivity130DecryptCo(actId, id)
	return self._act130DecryptConfig.configDict[actId][id]
end

function Activity130Config:getActivity130OperateGroupCos(actId, groupId)
	return self._act130OperGroupConfig.configDict[actId][groupId]
end

function Activity130Config:getActivity130ElementCo(actId, id)
	return self._act130ElementConfig.configDict[actId][id]
end

function Activity130Config:getActivity130DialogCo(dialogId, stepId)
	return lua_activity130_dialog.configDict[dialogId][stepId]
end

function Activity130Config:_initDialog()
	self._act130DialogList = {}

	local sectionId
	local defaultId = "0"

	for i, v in ipairs(lua_activity130_dialog.configList) do
		local group = self._act130DialogList[v.id]

		if not group then
			group = {
				optionParamList = {}
			}
			sectionId = defaultId
			self._act130DialogList[v.id] = group
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

function Activity130Config:getDialog(groupId, sectionId)
	local group = self._act130DialogList[groupId]

	return group and group[sectionId]
end

function Activity130Config:getOptionParamList(groupId)
	local group = self._act130DialogList[groupId]

	return group and group.optionParamList
end

function Activity130Config:getActivity130TaskCo(id)
	return self._act130TaskConfig.configDict[id]
end

function Activity130Config:getTaskByActId(actId)
	local list = {}

	for _, co in ipairs(self._act130TaskConfig.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

function Activity130Config:getOperGroup(actId, groupId)
	return self._act130OperGroupConfig.configDict[actId][groupId]
end

Activity130Config.instance = Activity130Config.New()

return Activity130Config
