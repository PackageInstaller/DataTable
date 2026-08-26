-- chunkname: @modules/logic/limited/view/LimitedRoleVoiceView.lua

module("modules.logic.limited.view.LimitedRoleVoiceView", package.seeall)

local LimitedRoleVoiceView = class("LimitedRoleVoiceView", BaseView)

function LimitedRoleVoiceView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "#go_contents")
	self._txtContent = gohelper.findChildText(self.viewGO, "#go_contents/go_normalcontent/txt_content")
	self._txtContentEn = gohelper.findChildText(self.viewGO, "#go_contents/go_normalcontent/txt_contenten")
end

function LimitedRoleVoiceView:onOpen()
	self._limitCO = self.viewParam.limitedCO

	local voiceId = self._limitCO.characterVoice

	self._voiceConfig = lua_character_limited_voice.configDict[voiceId]

	if self._voiceConfig then
		self:_initVoiceConfig()
	end
end

function LimitedRoleVoiceView:_initVoiceConfig()
	self:_initAddAudio(self._voiceConfig)
	self:_initContent(self._voiceConfig)
	self:_initVoice(self._voiceConfig)
end

function LimitedRoleVoiceView:_initVoice(voiceConfig)
	self._emitter = ZProj.AudioEmitter.Get(self.viewGO)

	local lang = self:_getVoiceLang()

	if lang then
		local audioCfg = AudioConfig.instance:getAudioCOById(voiceConfig.audio)
		local bnkName = audioCfg.bankName

		ZProj.AudioManager.Instance:LoadBank(bnkName, lang)
		self._emitter:Emitter(voiceConfig.audio, lang, self._onEmitterCallback, self)
		ZProj.AudioManager.Instance:UnloadBank(bnkName)
	else
		self._emitter:Emitter(voiceConfig.audio, self._onEmitterCallback, self)
	end
end

function LimitedRoleVoiceView:_getVoiceLang()
	local skinId = self._limitCO.id
	local skinConfig = lua_skin.configDict[skinId]
	local heroId = skinConfig and skinConfig.characterId

	if not heroId then
		logError("heroId is nil skinId:", skinId)

		return
	end

	local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
	local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

	if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
		return charVoiceLang
	end
end

function LimitedRoleVoiceView:_onEmitterCallback(callbackType, value)
	if callbackType == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif callbackType == AudioEnum.AkCallbackType.AK_EndOfEvent then
		self:_emitterStopVoice()
	end
end

function LimitedRoleVoiceView:_emitterStopVoice()
	self:_onVoiceStop()
end

function LimitedRoleVoiceView:_initContent(voiceConfig)
	gohelper.setActive(self._goContent, true)

	self._voiceText = LimitedRoleVoiceText.New()

	self._voiceText:init(voiceConfig, self._txtContent, self._txtContentEn)
end

function LimitedRoleVoiceView:_initAddAudio(voiceConfig)
	self._hasAddAudio = voiceConfig.addaudio and voiceConfig.addaudio ~= ""

	if self._hasAddAudio then
		self._addAudios = {}

		local curVoiceTypeIdx = GameLanguageMgr.instance:getVoiceTypeStoryIndex()
		local addAudiosParams = string.split(voiceConfig.addaudio, "|")

		for _, audioParam in pairs(addAudiosParams) do
			local params = string.splitToNumber(audioParam, "#")
			local audioId = params[1]
			local delayTime = params[curVoiceTypeIdx + 1]
			local audioItem = SpineVoiceAddAudio.New()

			audioItem:init(audioId, delayTime or 0)
			table.insert(self._addAudios, audioItem)
		end
	end
end

function LimitedRoleVoiceView:onClose()
	return
end

function LimitedRoleVoiceView:onDestroyView()
	self:_onVoiceStop()
end

function LimitedRoleVoiceView:_onVoiceStop()
	if self._addAudios then
		for _, audio in pairs(self._addAudios) do
			audio:onDestroy()
		end

		self._addAudios = nil
	end

	if self._voiceText then
		self._voiceText:onDestroy()
	end
end

return LimitedRoleVoiceView
