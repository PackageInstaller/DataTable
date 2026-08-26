-- chunkname: @modules/logic/versionactivity1_9/fairyland/config/FairyLandConfig.lua

module("modules.logic.versionactivity1_9.fairyland.config.FairyLandConfig", package.seeall)

local FairyLandConfig = class("FairyLandConfig", BaseConfig)

function FairyLandConfig:ctor()
	return
end

function FairyLandConfig:reqConfigNames()
	return {
		"fairyland_puzzle",
		"fairyland_puzzle_talk",
		"fairy_land_element",
		"fairyland_text"
	}
end

function FairyLandConfig:onConfigLoaded(configName, configTable)
	if configName == "fairyland_puzzle" then
		self._fairlyLandPuzzleConfig = configTable
	elseif configName == "fairyland_puzzle_talk" then
		self:_initDialog()
	elseif configName == "fairy_land_element" then
		self._fairlyLandElementConfig = configTable
	end
end

function FairyLandConfig:getFairlyLandPuzzleConfig(id)
	return self._fairlyLandPuzzleConfig.configDict[id]
end

function FairyLandConfig:getTalkStepConfig(id, step)
	local config = self:getTalkConfig(id)

	return config and config[step]
end

function FairyLandConfig:getElements()
	return self._fairlyLandElementConfig.configList
end

function FairyLandConfig:getElementConfig(elementId)
	return self._fairlyLandElementConfig.configDict[elementId]
end

function FairyLandConfig:_initDialog()
	self._dialogList = {}

	local sectionId
	local defaultId = 0

	for i, v in ipairs(lua_fairyland_puzzle_talk.configList) do
		local group = self._dialogList[v.id]

		if not group then
			group = {}
			sectionId = defaultId
			self._dialogList[v.id] = group
		end

		if v.type == "selector" then
			sectionId = tonumber(v.param)
			group[sectionId] = group[sectionId] or {}
		elseif v.type == "selectorend" then
			sectionId = defaultId
		else
			group[sectionId] = group[sectionId] or {}

			table.insert(group[sectionId], v)
		end
	end
end

function FairyLandConfig:getDialogConfig(dialogId, sectionId)
	local group = self._dialogList[dialogId]

	return group and group[sectionId]
end

function FairyLandConfig:addTextDict(text, node, dict)
	local group = dict[node]

	if not group then
		group = {}
		dict[node] = group
	end

	table.insert(group, text)
end

FairyLandConfig.instance = FairyLandConfig.New()

return FairyLandConfig
