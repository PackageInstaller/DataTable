-- chunkname: @modules/logic/story/config/StoryConfig.lua

module("modules.logic.story.config.StoryConfig", package.seeall)

local StoryConfig = class("StoryConfig", BaseConfig)

function StoryConfig:ctor()
	self._groupConfigs = {}
	self._stepConfigs = {}
	self._cutConfig = {}
	self._skipConfig = {}
	self._txtdiffConfig = {}
	self._fadeConfig = {}
	self._activityOpenConfig = {}
	self._prologueConfig = {}
	self._textRefrectConfig = {}
	self._leadHeroSpineConfig = {}
	self._picTxtsConfig = {}
	self._audioSwitchConfig = {}
	self._bgEffStarburstConfig = {}
end

function StoryConfig:onInit()
	self:_loadStoryConfig()
end

function StoryConfig:reqConfigNames()
	return {
		"herocut",
		"storyskip",
		"story_txtdiff",
		"storydialogfade",
		"story_activity_open",
		"story_prologue_synopsis",
		"story_text_reflect",
		"story_leadherospine",
		"story_pictxt",
		"story_audio_switch",
		"story_starburst"
	}
end

function StoryConfig:onConfigLoaded(configName, configTable)
	if configName == "herocut" then
		self._cutConfig = configTable
	elseif configName == "storyskip" then
		self._skipConfig = configTable
	elseif configName == "story_txtdiff" then
		self._txtdiffConfig = configTable
	elseif configName == "storydialogfade" then
		self._fadeConfig = configTable
	elseif configName == "story_activity_open" then
		self._activityOpenConfig = configTable
	elseif configName == "story_prologue_synopsis" then
		self._prologueConfig = configTable
	elseif configName == "story_text_reflect" then
		self._textRefrectConfig = configTable
	elseif configName == "story_leadherospine" then
		self._leadHeroSpineConfig = configTable
	elseif configName == "story_pictxt" then
		self._picTxtsConfig = configTable
	elseif configName == "story_audio_switch" then
		self._audioSwitchConfig = configTable
	elseif configName == "story_starburst" then
		self._bgEffStarburstConfig = configTable
	end
end

function StoryConfig:_loadStoryConfig()
	local heroConfig = addGlobalModule("modules.configs.story.lua_story_heroparam")

	StoryHeroLibraryModel.instance:setStoryHeroLibraryList(heroConfig)

	local bgEffTransConfig = addGlobalModule("modules.configs.story.lua_story_bgefftranstype")

	StoryBgEffectTransModel.instance:setStoryBgEffectTransList(bgEffTransConfig)

	local blurTypeConfig = addGlobalModule("modules.configs.story.lua_story_blurtype")

	StoryBlurTypeModel.instance:setStoryBlurTypeList(blurTypeConfig)

	local cameraEffectConfig = addGlobalModule("modules.configs.story.lua_story_cameraeffect")

	StoryCameraEffectModel.instance:setStoryCameraEffectList(cameraEffectConfig)

	local textureEffectTypeConfig = addGlobalModule("modules.configs.story.lua_story_textureeffecttype")

	StoryTextureEffectTypeModel.instance:setStoryTextureEffectTypeList(textureEffectTypeConfig)

	local shapeMaskEffectTypeConfig = addGlobalModule("modules.configs.story.lua_story_shapemasktype")

	StoryShapeMaskEffectTypeModel.instance:setStoryShapeMaskEffectTypeList(shapeMaskEffectTypeConfig)

	if GameResMgr.IsFromEditorDir then
		local zonePath = "configs/story/json_zone_storybg.json"

		loadNonAbAsset(zonePath, SLFramework.AssetType.TEXT, function(assetItem)
			if not assetItem.IsLoadSuccess then
				logError("config load fail: " .. assetItem.ResPath)

				return
			end

			local json = cjson.decode(assetItem.TextAsset)

			StoryBgZoneModel.instance:setZoneList(json)
		end)
	else
		local zonePath = "configs/story/json_zone_storybg.json"

		loadAbAsset("configs/story", false, function(assetItem)
			if assetItem.IsLoadSuccess then
				local zoneJson = cjson.decode(assetItem:GetResource(zonePath).text)

				StoryBgZoneModel.instance:setZoneList(zoneJson)
				assetItem:Retain()
			else
				logError("加载剧情bgzone json出错！")
			end
		end)
	end
end

function StoryConfig:loadStoryConfig(storyId, callback, callbackObj)
	if GameResMgr.IsFromEditorDir then
		local stepPath = string.format("configs/story/steps/json_story_step_%s.json", storyId)
		local isStepLoaded = false
		local isGroupLoaded = false

		loadNonAbAsset(stepPath, SLFramework.AssetType.TEXT, function(assetItem)
			if not assetItem.IsLoadSuccess then
				logError("config load fail: " .. assetItem.ResPath)

				return
			end

			local json = cjson.decode(assetItem.TextAsset)

			StoryStepModel.instance:setStepList(json[3])
			assetItem:Retain()

			isStepLoaded = true

			if isGroupLoaded and callback then
				callback(callbackObj)
			end
		end)

		local groupPath = string.format("configs/story/groups/json_story_group_%s.json", storyId)

		loadNonAbAsset(groupPath, SLFramework.AssetType.TEXT, function(assetItem)
			if not assetItem.IsLoadSuccess then
				logError("config load fail: " .. assetItem.ResPath)

				return
			end

			local json = cjson.decode(assetItem.TextAsset)

			StoryGroupModel.instance:setGroupList(json)
			assetItem:Retain()

			isGroupLoaded = true

			if isStepLoaded and callback then
				callback(callbackObj)
			end
		end)
	else
		local storyStepPath = string.format("configs/story/steps/json_story_step_%s.json", storyId)
		local storyGroupPath = string.format("configs/story/groups/json_story_group_%s.json", storyId)

		loadAbAsset("configs/story", false, function(assetItem)
			if assetItem.IsLoadSuccess then
				local stepJson = cjson.decode(assetItem:GetResource(storyStepPath).text)

				StoryStepModel.instance:setStepList(stepJson[3])

				local groupJson = cjson.decode(assetItem:GetResource(storyGroupPath).text)

				StoryGroupModel.instance:setGroupList(groupJson)

				if callback then
					callback(callbackObj)
				end

				assetItem:Retain()
			else
				logError("加载剧情运行json出错！")
			end
		end)
	end
end

function StoryConfig:getActivityOpenConfig(chapter, part)
	local chapterCos = self._activityOpenConfig.configDict[chapter]

	return chapterCos and chapterCos[part]
end

function StoryConfig:getStoryCutConfig()
	return self._cutConfig.configDict
end

function StoryConfig:getStorySkipConfig(id)
	return self._skipConfig.configDict[id]
end

function StoryConfig:getStoryTxtDiffConfig()
	return self._txtdiffConfig.configDict
end

function StoryConfig:getStoryDialogFadeConfig()
	return self._fadeConfig.configDict
end

function StoryConfig:getStoryPrologueSkipConfig()
	return self._prologueConfig.configDict
end

function StoryConfig:getStoryTextReflectConfig()
	return self._textRefrectConfig.configDict
end

function StoryConfig:getStoryLeadHeroSpine()
	return self._leadHeroSpineConfig.configDict
end

function StoryConfig:getStoryPicTxtConfig(id)
	return self._picTxtsConfig.configDict[id]
end

function StoryConfig:getStoryAudioSwitchConfig(id)
	return self._audioSwitchConfig.configDict[id]
end

function StoryConfig:getStoryStarburstConfig(id)
	return self._bgEffStarburstConfig.configDict[id]
end

function StoryConfig:getEpisodeStoryIds(config)
	local storyIds = {}

	if not config then
		return storyIds
	end

	if config.beforeStory > 0 then
		table.insert(storyIds, config.beforeStory)
	end

	local fightStories = self:getEpisodeFightStory(config)

	tabletool.addValues(storyIds, fightStories)

	if config.afterStory > 0 then
		table.insert(storyIds, config.afterStory)
	end

	return storyIds
end

function StoryConfig:getEpisodeFightStory(config)
	local storyIds = {}

	if not string.nilorempty(config.story) then
		local storiesParams = string.split(config.story, "|")

		for i = 1, #storiesParams do
			local storyParams = storiesParams[i]

			storyParams = string.split(storyParams, "#")

			if storyParams[3] then
				local storyId = tonumber(storyParams[3])

				if storyParams[3] and storyParams[3] > 0 then
					table.insert(storyIds, storyParams[3])
				end
			end
		end
	end

	return storyIds
end

function StoryConfig:replaceStoryMagicText(txt)
	for _, config in pairs(self._textRefrectConfig.configDict) do
		txt = string.gsub(txt, config.magicText, config.normalText)
	end

	return txt
end

function StoryConfig:getMaterialConfig(id)
	if self._materialConfig == nil then
		self._materialConfig = addGlobalModule("modules.configs.story.lua_story_material_config")
	end

	return self._materialConfig[id]
end

StoryConfig.instance = StoryConfig.New()

return StoryConfig
