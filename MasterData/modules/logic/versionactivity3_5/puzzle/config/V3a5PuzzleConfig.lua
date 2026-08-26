-- chunkname: @modules/logic/versionactivity3_5/puzzle/config/V3a5PuzzleConfig.lua

module("modules.logic.versionactivity3_5.puzzle.config.V3a5PuzzleConfig", package.seeall)

local V3a5PuzzleConfig = class("V3a5PuzzleConfig", BaseConfig)

function V3a5PuzzleConfig:reqConfigNames()
	return {
		"v3a5_constant",
		"v3a5_text",
		"v3a5_character"
	}
end

function V3a5PuzzleConfig:onInit()
	return
end

function V3a5PuzzleConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function V3a5PuzzleConfig:v3a5_textConfigLoaded(configTable)
	self._dialogDict = {}

	for _, co in ipairs(configTable.configList) do
		self._dialogDict[co.groupId] = self._dialogDict[co.groupId] or {}

		table.insert(self._dialogDict[co.groupId], co)
	end
end

function V3a5PuzzleConfig:getConstValue(constId, isValue2)
	local co = lua_v3a5_constant.configDict[constId]

	if co then
		::label_5_0::

		local var_5_0

		if isValue2 then
			var_5_0 = co.value2 or co.value
		end
	end

	return var_5_0
end

function V3a5PuzzleConfig:getCharacterCo(heroId)
	return lua_v3a5_character.configDict[heroId]
end

function V3a5PuzzleConfig:getDialogGroupCos(groupId)
	return self._dialogDict[groupId]
end

V3a5PuzzleConfig.instance = V3a5PuzzleConfig.New()

return V3a5PuzzleConfig
