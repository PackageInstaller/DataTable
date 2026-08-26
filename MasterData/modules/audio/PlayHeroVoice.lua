-- chunkname: @modules/audio/PlayHeroVoice.lua

module("modules.audio.PlayHeroVoice", package.seeall)

local PlayHeroVoice = class("PlayHeroVoice")

function PlayHeroVoice:ctor()
	return
end

function PlayHeroVoice:init(voiceConfig, txtContent, txtEnContent, contentBg)
	if voiceConfig and voiceConfig.audio then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	end

	self._voiceConfig = voiceConfig
	self._txtContent = txtContent
	self._txtEnContent = txtEnContent
	self._goContentBg = contentBg
	self._hasAudio = AudioConfig.instance:getAudioCOById(voiceConfig.audio)

	if self._txtContent then
		self._contentStart = Time.time
		self._contentList = {}

		self:_initContent(self._contentList, self:getContent(voiceConfig))
	end

	if self._txtEnContent then
		self._enContentStart = Time.time
		self._enContentList = {}

		self:_initContent(self._enContentList, self:getContent(voiceConfig, LanguageEnum.LanguageStoryType.EN))
	end

	self:playVoice()
	TaskDispatcher.runRepeat(self._showContent, self, 0.1)
end

function PlayHeroVoice:_showContent()
	self:_showOneLang(self._contentList, self._contentStart, self._txtContent)
	self:_showOneLang(self._enContentList, self._enContentStart, self._txtEnContent)
	self:_checkTxtEnd()
end

function PlayHeroVoice:_showOneLang(contentList, startTime, txtContent)
	if contentList then
		local contentParam = contentList[1]

		if not contentParam then
			return
		end

		if not contentParam[2] then
			local txtStartTime = 0

			if contentParam and not contentParam[2] then
				logError("没有配置时间 audio:" .. self._voiceConfig.audio)
			end

			if txtStartTime <= Time.time - startTime then
				txtContent.text = contentParam[1]

				table.remove(contentList, 1)
			end
		end
	end
end

function PlayHeroVoice:_checkTxtEnd()
	if self._hasAudio then
		return
	end

	if self:_contentListEmpty() and self._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(self._showContent, self)
		TaskDispatcher.runDelay(self._onTxtEnd, self, self._voiceConfig.displayTime)
	end
end

function PlayHeroVoice:_onTxtEnd()
	TaskDispatcher.cancelTask(self._onTxtEnd, self)
	self:onVoiceTxtStop()
end

function PlayHeroVoice:getContent(voiceConfig, type)
	if not type then
		::label_7_0::

		local languageType = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local curLanVoice = GameConfig:GetCurVoiceShortcut()
		local targetIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLanVoice)

		return (SpineVoiceTextHelper.getSeparateContent(voiceConfig, languageType, targetIndex))
	end
end

function PlayHeroVoice:getVoiceLang(voiceConfig)
	self._lang = self._hasAudio and AudioMgr.instance:getLangByAudioId(voiceConfig.audio) or AudioMgr.instance:getCurLang()

	return self._lang
end

function PlayHeroVoice:contentListIsEmpty()
	return (not self._contentList or #self._contentList == 0) and (not self._enContentList or #self._enContentList == 0)
end

function PlayHeroVoice:_initContent(contentList, content)
	local list = string.split(content, "|")

	for i, v in ipairs(list) do
		if v ~= "" then
			local param = string.split(v, "#")

			param[2] = tonumber(param[2])

			table.insert(contentList, param)
		end
	end
end

function PlayHeroVoice:removeTaskActions()
	TaskDispatcher.cancelTask(self._showContent, self)
	TaskDispatcher.cancelTask(self._onTxtEnd, self)
end

function PlayHeroVoice:onVoiceTxtStop()
	self:removeTaskActions()

	if not gohelper.isNil(self._txtContent) then
		self._txtContent.text = ""
	end

	if not gohelper.isNil(self._txtEnContent) then
		self._txtEnContent.text = ""
	end
end

function PlayHeroVoice:playVoice()
	if self._hasAudio then
		self._emitter = ZProj.AudioEmitter.Get(self._goContentBg)

		if not self._emitter then
			self:_onVoiceEnd()

			return
		end

		self._emitter:Emitter(self._voiceConfig.audio, self._onEmitterCallback, self)
	else
		self:_onVoiceEnd()
	end
end

function PlayHeroVoice:_onEmitterCallback(callbackType, value)
	if callbackType == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif callbackType == AudioEnum.AkCallbackType.AK_EndOfEvent then
		self:_onVoiceEnd()
	end
end

function PlayHeroVoice:_onVoiceEnd()
	self:onVoiceTxtStop()
end

function PlayHeroVoice:dispose()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)
	self:_onVoiceEnd()

	self._emitter = nil
end

return PlayHeroVoice
