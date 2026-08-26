-- chunkname: @modules/logic/common/config/AudioConfig.lua

module("modules.logic.common.config.AudioConfig", package.seeall)

local AudioConfig = class("AudioConfig", BaseConfig)

setNeedLoadModule("modules.logic.common.config.auto_mouth_data", "auto_mouth_data")

function AudioConfig:reqConfigNames()
	return {
		"role_audio",
		"ui_audio",
		"bg_audio",
		"fight_audio",
		"story_audio",
		"story_role_audio",
		"effect_audio",
		"effect_with_audio",
		"story_audio_main",
		"story_audio_branch",
		"story_audio_system",
		"story_audio_role",
		"story_audio_effect",
		"story_audio_short"
	}
end

function AudioConfig:onInit()
	self:_loadAutoMouthConfig()
end

function AudioConfig:onConfigLoaded(configName, configTable)
	if configName == "effect_with_audio" then
		local prefix = "effects/prefabs/"
		local suffix = ".prefab"

		self._effectToAudioConfigDict = {}

		for _, config in pairs(configTable.configDict) do
			self._effectToAudioConfigDict[prefix .. config.effect .. suffix] = config
		end
	end
end

function AudioConfig:InitCSByConfig(csharpInst)
	for _, item in pairs(self:getAudioCO()) do
		self:_InitCS(csharpInst, item)
	end
end

function AudioConfig:_InitCS(csharpInst, item)
	if not csharpInst then
		return
	end

	csharpInst:InitConfig(item.id, item.eventName, item.bankName)
end

function AudioConfig:getAudioCO()
	if not self._audioId2AudioCODict then
		self._audioId2AudioCODict = {}

		self:_buildRelation(lua_role_audio.configList)
		self:_buildRelation(lua_ui_audio.configList)
		self:_buildRelation(lua_bg_audio.configList)
		self:_buildRelation(lua_fight_audio.configList)
		self:_buildRelation(lua_story_audio.configList)
		self:_buildRelation(lua_story_audio_main.configList)
		self:_buildRelation(lua_story_audio_branch.configList)
		self:_buildRelation(lua_story_audio_system.configList)
		self:_buildRelation(lua_story_audio_role.configList)
		self:_buildRelation(lua_story_audio_effect.configList)
		self:_buildRelation(lua_story_audio_short.configList)
		self:_buildRelation(lua_story_role_audio.configList)
		self:_buildRelation(lua_effect_audio.configList)
	end

	return self._audioId2AudioCODict
end

function AudioConfig:getAudioCOById(audioId)
	self:getAudioCO()

	return self._audioId2AudioCODict[audioId]
end

function AudioConfig:_buildRelation(configList)
	for _, item in ipairs(configList) do
		self._audioId2AudioCODict[item.id] = item
	end
end

function AudioConfig:getAudioConfig(effectPath)
	return self._effectToAudioConfigDict and self._effectToAudioConfigDict[effectPath]
end

function AudioConfig:_loadAutoMouthConfig()
	self._allMouthDic = {}

	if GameResMgr.IsFromEditorDir then
		local arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/auto_mouth")
		local length = arr.Length

		for i = 1, length do
			local path = arr[i - 1]

			if not string.find(path, ".meta") then
				local fileName = SLFramework.FileHelper.GetFileName(path, true)
				local configPath = "configs/auto_mouth/" .. fileName

				loadNonAbAsset(configPath, SLFramework.AssetType.TEXT, self._onConfigNoAbCallback, self)
			end
		end
	else
		loadAbAsset("configs/auto_mouth", false, self._onConfigAbCallback, self)
	end
end

function AudioConfig:_onConfigNoAbCallback(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("config load fail: " .. assetItem.ResPath)

		return
	end

	local fileName = SLFramework.FileHelper.GetFileName(assetItem.ResPath, false)

	self._allMouthDic[fileName] = self:_decodeJsonStr(assetItem.TextAsset)
end

function AudioConfig:_decodeJsonStr(jsonString)
	local json

	if isDebugBuild then
		local ok, ret = pcall(cjson.decode, jsonString)

		if not ok then
			logError("配置解析失败: " .. jsonString)

			return
		end

		json = ret
	else
		json = cjson.decode(jsonString)
	end

	return json
end

function AudioConfig:_onConfigAbCallback(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("config load fail: " .. assetItem.ResPath)

		return
	end

	assetItem:Retain()

	self._autoMouthAssetItem = assetItem
end

function AudioConfig:getAutoMouthData(audioId, lang)
	local audioCO = self:getAudioCOById(audioId)

	if audioCO then
		local data = self._allMouthDic[audioCO.bankName]

		if data == nil and self._autoMouthAssetItem then
			local res = self._autoMouthAssetItem:GetResource("configs/auto_mouth/" .. audioCO.bankName .. ".json")

			if res then
				data = cjson.decode(res.text)
				self._allMouthDic[audioCO.bankName] = data
			end
		end

		if data and data[audioCO.eventName] then
			return data[audioCO.eventName][lang]
		end
	end
end

AudioConfig.instance = AudioConfig.New()

return AudioConfig
