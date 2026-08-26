-- chunkname: @modules/spine/SpineVoiceText.lua

module("modules.spine.SpineVoiceText", package.seeall)

local SpineVoiceText = class("SpineVoiceText")

function SpineVoiceText:onDestroy()
	self:removeTaskActions()

	self._spineVoice = nil
	self._voiceConfig = nil
	self._txtContent = nil
	self._txtEnContent = nil
	self._showBg = nil
end

function SpineVoiceText:init(spineVoice, voiceConfig, txtContent, txtEnContent, showBg)
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._txtContent = txtContent
	self._txtEnContent = txtEnContent
	self._showBg = showBg
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

	if not self._showBg then
		self._spineVoice:setBgVisible(false)
	end

	if self:_contentListEmpty() then
		self._spineVoice:setBgVisible(false)
	end

	if not self._voiceConfig.displayTime then
		return
	end

	TaskDispatcher.runRepeat(self._showContent, self, 0.1)
end

function SpineVoiceText:getContent(voiceCo, type)
	if not type then
		::label_3_0::

		local languageType = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local curLanVoice = self._spineVoice:getVoiceLang()
		local targetIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLanVoice)

		return (SpineVoiceTextHelper.getSeparateContent(voiceCo, languageType, targetIndex))
	end
end

function SpineVoiceText:_showContent()
	self:_showOneLang(self._contentList, self._contentStart, self._txtContent)
	self:_showOneLang(self._enContentList, self._enContentStart, self._txtEnContent)
	self:_checkEnd()
end

function SpineVoiceText:_checkEnd()
	if self._hasAudio then
		return
	end

	if self:_contentListEmpty() and self._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(self._showContent, self)
		TaskDispatcher.runDelay(self._onEnd, self, self._voiceConfig.displayTime)
	end
end

function SpineVoiceText:_contentListEmpty()
	return (not self._contentList or #self._contentList == 0) and (not self._enContentList or #self._enContentList == 0)
end

function SpineVoiceText:_onEnd()
	TaskDispatcher.cancelTask(self._onEnd, self)
	self:onVoiceStop()
end

function SpineVoiceText:_showOneLang(contentList, startTime, txtContent)
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

				if not self._showBg then
					self._spineVoice:setBgVisible(true)
				end
			end
		end
	end
end

function SpineVoiceText:_initContent(contentList, content)
	local list = string.split(content, "|")

	for i, v in ipairs(list) do
		if v ~= "" then
			local param = string.split(v, "#")

			param[2] = tonumber(param[2])

			table.insert(contentList, param)
		end
	end
end

function SpineVoiceText:removeTaskActions()
	TaskDispatcher.cancelTask(self._showContent, self)
	TaskDispatcher.cancelTask(self._onEnd, self)
end

function SpineVoiceText:onVoiceStop()
	self:removeTaskActions()

	if self._showBg then
		return
	end

	if not gohelper.isNil(self._txtContent) then
		self._txtContent.text = ""
	end

	if not gohelper.isNil(self._txtEnContent) then
		self._txtEnContent.text = ""
	end

	if self._spineVoice then
		self._spineVoice:setBgVisible(false)
	end
end

return SpineVoiceText
