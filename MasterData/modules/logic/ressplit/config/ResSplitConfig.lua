-- chunkname: @modules/logic/ressplit/config/ResSplitConfig.lua

module("modules.logic.ressplit.config.ResSplitConfig", package.seeall)

local ResSplitConfig = class("ResSplitConfig", BaseConfig)

function ResSplitConfig:onInit()
	return
end

function ResSplitConfig:reqConfigNames()
	return {
		"app_include",
		"version_res_split"
	}
end

function ResSplitConfig:onConfigLoaded(configName, configTable)
	if configName == "app_include" then
		self._appIncludeConfig = configTable
	end
end

function ResSplitConfig:getAppIncludeConfig()
	return self._appIncludeConfig.configDict
end

function ResSplitConfig:getMaxWeekWalkLayer()
	if self._maxLayer == nil then
		self._maxLayer = 0

		for i, v in pairs(self._appIncludeConfig.configDict) do
			self._maxLayer = math.max(self._maxLayer, v.maxWeekWalk)
		end
	end

	return self._maxLayer
end

function ResSplitConfig:getAllChapterIds()
	if self._allChapterIds == nil then
		self._allChapterIds = {}

		for i, v in pairs(self._appIncludeConfig.configDict) do
			for n, id in pairs(v.chapter) do
				self._allChapterIds[id] = true
			end
		end
	end

	return self._allChapterIds
end

function ResSplitConfig:isSaveChapter(id)
	self:getAllChapterIds()

	return self._allChapterIds[id]
end

function ResSplitConfig:getAllCharacterIds()
	if self._allCharacterIds == nil then
		self._allCharacterIds = {}

		for i, v in pairs(self._appIncludeConfig.configDict) do
			for n, id in pairs(v.character) do
				self._allCharacterIds[id] = true
			end
		end
	end

	return self._allCharacterIds
end

ResSplitConfig.instance = ResSplitConfig.New()

return ResSplitConfig
