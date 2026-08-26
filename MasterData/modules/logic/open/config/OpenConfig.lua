-- chunkname: @modules/logic/open/config/OpenConfig.lua

module("modules.logic.open.config.OpenConfig", package.seeall)

local OpenConfig = class("OpenConfig", BaseConfig)

function OpenConfig:ctor()
	self._openConfig = nil
	self._opengroupConfig = nil
end

function OpenConfig:reqConfigNames()
	return {
		"open",
		"open_group",
		"open_lang"
	}
end

function OpenConfig:onConfigLoaded(configName, configTable)
	if configName == "open" then
		self._openConfig = configTable

		self:_initOpenConfig()
	elseif configName == "open_group" then
		self._opengroupConfig = configTable

		self:_initOpenGroupConfig()
	elseif configName == "open_lang" then
		self._openglangConfig = configTable

		self:_initOpenLangConfig()
	end
end

function OpenConfig:_initOpenConfig()
	self._openShowInEpisodeList = {}

	for i, v in ipairs(self._openConfig.configList) do
		if v.showInEpisode == 1 then
			if not self._openShowInEpisodeList[v.episodeId] then
				self._openShowInEpisodeList[v.episodeId] = self._openShowInEpisodeList[v.episodeId]

				table.insert(self._openShowInEpisodeList[v.episodeId], v.id)
			end
		end
	end
end

function OpenConfig:_initOpenGroupConfig()
	self._openGroupShowInEpisodeList = {}

	for i, v in ipairs(self._opengroupConfig.configList) do
		if v.showInEpisode == 1 then
			if not self._openGroupShowInEpisodeList[v.need_episode] then
				self._openGroupShowInEpisodeList[v.need_episode] = self._openGroupShowInEpisodeList[v.need_episode]

				table.insert(self._openGroupShowInEpisodeList[v.need_episode], v.id)
			end
		end
	end
end

function OpenConfig:_initOpenLangConfig()
	self._openLangTxtsDic = {}
	self._openLangVoiceDic = {}
	self._openLangStoryVoiceDic = {}

	local config = self._openglangConfig.configList[1]
	local langTxts = string.split(config.langTxts, "#")
	local langVoice = string.split(config.langVoice, "#")
	local langStoryVoice = string.split(config.langStoryVoice, "#")

	for i, v in ipairs(langTxts) do
		self._openLangTxtsDic[v] = true
	end

	for i, v in ipairs(langVoice) do
		self._openLangVoiceDic[v] = true
	end

	for i, v in ipairs(langStoryVoice) do
		self._openLangStoryVoiceDic[v] = true
	end
end

function OpenConfig:isOpenLangTxt(lang)
	return self._openLangTxtsDic[lang]
end

function OpenConfig:isOpenLangVoice(lang)
	return self._openLangVoiceDic[lang]
end

function OpenConfig:isOpenLangStoryVoice(lang)
	return self._openLangStoryVoiceDic[lang]
end

function OpenConfig:getOpenShowInEpisode(id)
	return self._openShowInEpisodeList[id]
end

function OpenConfig:getOpenGroupShowInEpisode(id)
	return self._openGroupShowInEpisodeList[id]
end

function OpenConfig:getOpensCO()
	return self._openConfig.configDict
end

function OpenConfig:getOpenCo(id)
	return self._openConfig.configDict[id]
end

function OpenConfig:getOpenGroupsCo()
	return self._opengroupConfig.configDict
end

function OpenConfig:getOpenGroupCO(id)
	return self._opengroupConfig.configDict[id]
end

function OpenConfig:isShowWaterMarkConfig()
	self.isShowWaterMark = self.isShowWaterMark or SLFramework.GameConfig.Instance.ShowWaterMark

	return self.isShowWaterMark
end

OpenConfig.instance = OpenConfig.New()

return OpenConfig
