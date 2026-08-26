-- chunkname: @modules/logic/limited/view/LimitedRoleVoiceText.lua

module("modules.logic.limited.view.LimitedRoleVoiceText", package.seeall)

local LimitedRoleVoiceText = class("LimitedRoleVoiceText")

function LimitedRoleVoiceText:onDestroy()
	self:onVoiceStop()

	self._voiceConfig = nil
	self._txtContent = nil
	self._txtEnContent = nil
end

function LimitedRoleVoiceText:init(voiceConfig, txtContent, txtEnContent)
	self._voiceConfig = voiceConfig
	self._txtContent = txtContent
	self._txtEnContent = txtEnContent

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

	TaskDispatcher.runRepeat(self._showContent, self, 0.1)
end

function LimitedRoleVoiceText:getContent(voiceCo, type)
	if not type then
		::label_3_0::

		local languageType = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local curLanVoice = AudioMgr.instance:getLangByAudioId(self._voiceConfig.audio)
		local targetIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLanVoice)

		return (SpineVoiceTextHelper.getSeparateContent(voiceCo, languageType, targetIndex))
	end
end

function LimitedRoleVoiceText:_showContent()
	self:_showOneLang(self._contentList, self._contentStart, self._txtContent)
	self:_showOneLang(self._enContentList, self._enContentStart, self._txtEnContent)
	self:_checkEnd()
end

function LimitedRoleVoiceText:_checkEnd()
	return
end

function LimitedRoleVoiceText:_contentListEmpty()
	return (not self._contentList or #self._contentList == 0) and (not self._enContentList or #self._enContentList == 0)
end

function LimitedRoleVoiceText:_onEnd()
	TaskDispatcher.cancelTask(self._onEnd, self)
	self:onVoiceStop()
end

function LimitedRoleVoiceText:_showOneLang(contentList, startTime, txtContent)
	if contentList then
		local contentParam = contentList[1]

		if not contentParam then
			return
		end

		if not contentParam[2] then
			local txtStartTime = 0

			if contentParam and not contentParam[2] then
				logError("没有配置时间 id:" .. self._voiceConfig.id)
			end

			if txtStartTime <= Time.time - startTime then
				txtContent.text = contentParam[1]

				table.remove(contentList, 1)
			end
		end
	end
end

function LimitedRoleVoiceText:_initContent(contentList, content)
	local list = string.split(content, "|")

	for i, v in ipairs(list) do
		if v ~= "" then
			local param = string.split(v, "#")

			param[2] = tonumber(param[2])

			table.insert(contentList, param)
		end
	end
end

function LimitedRoleVoiceText:removeTaskActions()
	TaskDispatcher.cancelTask(self._showContent, self)
	TaskDispatcher.cancelTask(self._onEnd, self)
end

function LimitedRoleVoiceText:onVoiceStop()
	self:removeTaskActions()

	if not gohelper.isNil(self._txtContent) then
		self._txtContent.text = ""
	end

	if not gohelper.isNil(self._txtEnContent) then
		self._txtEnContent.text = ""
	end
end

return LimitedRoleVoiceText
