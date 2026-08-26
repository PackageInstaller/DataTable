-- chunkname: @modules/logic/weekwalk/config/WeekWalkConfig.lua

module("modules.logic.weekwalk.config.WeekWalkConfig", package.seeall)

local WeekWalkConfig = class("WeekWalkConfig", BaseConfig)

function WeekWalkConfig:reqConfigNames()
	return {
		"weekwalk",
		"weekwalk_element",
		"weekwalk_buff",
		"weekwalk_buff_pool",
		"weekwalk_level",
		"weekwalk_bonus",
		"weekwalk_element_res",
		"weekwalk_dialog",
		"weekwalk_question",
		"weekwalk_pray",
		"weekwalk_handbook",
		"weekwalk_branch",
		"weekwalk_type",
		"weekwalk_scene",
		"weekwalk_rule"
	}
end

function WeekWalkConfig:onInit()
	return
end

function WeekWalkConfig:onConfigLoaded(configName, configTable)
	if configName == "weekwalk_dialog" then
		self:_initDialog()
	elseif configName == "weekwalk" then
		self:_initWeekwalk()
	end
end

function WeekWalkConfig:getSceneConfigByLayer(layerId)
	for i, v in ipairs(lua_weekwalk.configList) do
		if v.layer == layerId then
			return lua_weekwalk_scene.configDict[v.sceneId]
		end
	end
end

function WeekWalkConfig:_initWeekwalk()
	self._issueList = {}

	for i, v in ipairs(lua_weekwalk.configList) do
		if v.issueId > 0 then
			if not self._issueList[v.issueId] then
				self._issueList[v.issueId] = self._issueList[v.issueId]

				table.insert(self._issueList[v.issueId], v)
			end
		end
	end
end

function WeekWalkConfig:getDeepLayer(issueId)
	return self._issueList[issueId]
end

function WeekWalkConfig:_initDialog()
	self._dialogList = {}

	local sectionId
	local defaultId = "0"

	for i, v in ipairs(lua_weekwalk_dialog.configList) do
		local group = self._dialogList[v.id]

		if not group then
			group = {
				optionParamList = {}
			}
			sectionId = defaultId
			self._dialogList[v.id] = group
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

function WeekWalkConfig:getDialog(groupId, sectionId)
	local group = self._dialogList[groupId]

	return group and group[sectionId]
end

function WeekWalkConfig:getOptionParamList(groupId)
	local group = self._dialogList[groupId]

	return group and group.optionParamList
end

function WeekWalkConfig:getMapConfig(id)
	return lua_weekwalk.configDict[id]
end

function WeekWalkConfig:getMapTypeConfig(id)
	if not id then
		return nil
	end

	local mapConfig = self:getMapConfig(id)

	return lua_weekwalk_type.configDict[mapConfig.type]
end

function WeekWalkConfig:getElementConfig(id)
	local config = lua_weekwalk_element.configDict[id]

	if not config then
		logError(string.format("getElementConfig no config id:%s", id))
	end

	return config
end

function WeekWalkConfig:getLevelConfig(level)
	return lua_weekwalk_level.configDict[level]
end

function WeekWalkConfig:getBonus(id, level)
	return lua_weekwalk_bonus.configDict[id][level].bonus
end

function WeekWalkConfig:getQuestionConfig(id)
	return lua_weekwalk_question.configDict[id]
end

function WeekWalkConfig:getMapBranchCoList(mapId)
	if self.mapIdToBranchCoDict then
		return self.mapIdToBranchCoDict[mapId]
	end

	self.mapIdToBranchCoDict = {}

	for _, co in ipairs(lua_weekwalk_branch.configList) do
		self.mapIdToBranchCoDict[co.mapId] = self.mapIdToBranchCoDict[co.mapId] or {}

		table.insert(self.mapIdToBranchCoDict[co.mapId], co)
	end

	return self.mapIdToBranchCoDict[mapId]
end

WeekWalkConfig.instance = WeekWalkConfig.New()

return WeekWalkConfig
