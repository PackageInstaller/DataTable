-- chunkname: @modules/logic/scene/config/SceneConfig.lua

module("modules.logic.scene.config.SceneConfig", package.seeall)

local SceneConfig = class("SceneConfig", BaseConfig)

function SceneConfig:ctor()
	self._scene2LevelCOs = nil
end

function SceneConfig:reqConfigNames()
	return {
		"scene",
		"scene_level",
		"camera",
		"loading_text",
		"loading_icon",
		"scene_ctrl"
	}
end

function SceneConfig:onConfigLoaded(configName, configTable)
	if configName == "loading_icon" then
		self:_initLoadingIcon()
	elseif configName == "loading_text" then
		self:_initLoadingText()
	end
end

function SceneConfig:_initLoadingIcon()
	self._loadingIconList = {}

	for i, v in ipairs(lua_loading_icon.configList) do
		if v.isOnline == 1 then
			table.insert(self._loadingIconList, v)
		end
	end
end

function SceneConfig:_initLoadingText()
	self._loadingTextList = {}

	for i, v in ipairs(lua_loading_text.configList) do
		if v.isOnline == 1 then
			table.insert(self._loadingTextList, v)
		end
	end
end

function SceneConfig:getSceneLevelCOs(sceneId)
	self._scene2LevelCOs = self._scene2LevelCOs or {}

	local scneCO = lua_scene.configDict[sceneId]

	if not scneCO then
		logError("scene config not exist: " .. tostring(sceneId))

		return
	end

	if not self._scene2LevelCOs[sceneId] then
		self._scene2LevelCOs[sceneId] = {}

		for _, levelId in ipairs(scneCO.levels) do
			local levelCO = lua_scene_level.configDict[levelId]

			if levelCO then
				table.insert(self._scene2LevelCOs[sceneId], levelCO)
			else
				logError("scene level config not exist: " .. tostring(levelId))
			end
		end
	end

	return self._scene2LevelCOs[sceneId]
end

function SceneConfig:getLoadingIcons()
	return self._loadingIconList
end

function SceneConfig:getLoadingTexts()
	return self._loadingTextList
end

SceneConfig.instance = SceneConfig.New()

return SceneConfig
