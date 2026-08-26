-- chunkname: @modules/spine/SpineVoiceAudio.lua

module("modules.spine.SpineVoiceAudio", package.seeall)

local SpineVoiceAudio = class("SpineVoiceAudio")

function SpineVoiceAudio:ctor()
	return
end

function SpineVoiceAudio:onDestroy()
	self._spineVoice = nil
	self._voiceConfig = nil
	self._spine = nil
	self._addAudios = nil
end

function SpineVoiceAudio:_playAudio()
	if self._lang then
		local audioCfg = AudioConfig.instance:getAudioCOById(self._voiceConfig.audio)
		local bnkName = audioCfg.bankName

		ZProj.AudioManager.Instance:LoadBank(bnkName, self._lang)
		self._emitter:Emitter(self._voiceConfig.audio, self._lang, self._onEmitterCallback, self)
		ZProj.AudioManager.Instance:UnloadBank(bnkName)
	else
		self._emitter:Emitter(self._voiceConfig.audio, self._onEmitterCallback, self)
	end

	print("playVoice:", self._voiceConfig.audio)
	AudioMgr.instance:addAudioLog(self._voiceConfig.audio, "yellow", "播放音效开始")
end

function SpineVoiceAudio:_initAudio()
	if not string.nilorempty(self._voiceConfig.effects) then
		local voiceEffects = string.splitToNumber(self._voiceConfig.effects, "|")
		local effectParams = GameUtil.splitString2(self._voiceConfig.effectParams, true, "|", "#")

		if not self._lang then
			local lang = AudioMgr.instance:getCurLang()
			local targetIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(lang)

			for i, effectType in ipairs(voiceEffects) do
				if effectType == CharacterVoiceEnum.EffectsType.DelayPlayAudio then
					local duration = effectParams[i][targetIndex]

					if duration then
						TaskDispatcher.cancelTask(self._playAudio, self)
						TaskDispatcher.runDelay(self._playAudio, self, duration)

						return
					else
						logError(string.format("SpineVoiceAudio _initAudio duration is nil for audio:%s effectType %s targetIndex:%s", self._voiceConfig.audio, effectType, targetIndex))
					end
				end
			end
		end
	end

	self:_playAudio()
end

function SpineVoiceAudio:init(spineVoice, voiceConfig, spine, lang)
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._spine = spine
	self._lang = lang

	TaskDispatcher.cancelTask(self._playAudio, self)

	self._hasAudio = AudioConfig.instance:getAudioCOById(voiceConfig.audio)

	if self._hasAudio then
		self._emitter = ZProj.AudioEmitter.Get(spine:getSpineGo())

		if not self._emitter then
			self:_onVoiceEnd()

			return
		end

		self:_initAudio()
	else
		print("playVoice no audio:", voiceConfig.audio)
		self:_onVoiceEnd()
	end

	self._hasAddAudio = voiceConfig.addaudio and voiceConfig.addaudio ~= ""

	if self._hasAddAudio then
		self._addAudios = {}

		local curVoiceTypeIdx = GameLanguageMgr.instance:getVoiceTypeStoryIndex()
		local addAudiosParams = string.split(voiceConfig.addaudio, "|")

		for _, audioParam in pairs(addAudiosParams) do
			local params = string.splitToNumber(audioParam, "#")
			local audioId = params[1]
			local delayTime = params[((lang or nil) and GameLanguageMgr.instance:getStoryIndexByShortCut(lang)) + 1]
			local audioItem = SpineVoiceAddAudio.New()

			audioItem:init(audioId, delayTime or 0)
			table.insert(self._addAudios, audioItem)
		end
	end
end

function SpineVoiceAudio:hasAudio()
	return self._hasAudio
end

function SpineVoiceAudio:setSwitch(spine, switchGroup, switchState)
	self._emitter = self._emitter or ZProj.AudioEmitter.Get(spine:getSpineGo())

	if self._emitter then
		self._emitter:SetSwitch(switchGroup, switchState)
	end
end

function SpineVoiceAudio:_onEmitterCallback(callbackType, value)
	if callbackType == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif callbackType == AudioEnum.AkCallbackType.AK_EndOfEvent then
		self:_emitterStopVoice()
	end
end

function SpineVoiceAudio:_emitterStopVoice()
	self:_onVoiceEnd()
end

function SpineVoiceAudio:_onVoiceEnd()
	if not self._spineVoice then
		return
	end

	if self._hasAudio then
		self._spineVoice:onSpineVoiceAudioStop()
	end

	self._spineVoice:_onComponentStop(self)

	if self._hasAudio then
		AudioMgr.instance:addAudioLog(self._voiceConfig.audio, "green", "播放音效结束")
	end
end

function SpineVoiceAudio:getEmitter()
	if self._spine then
		if self._emitter == nil or gohelper.isNil(self._emitter) then
			self._emitter = ZProj.AudioEmitter.Get(self._spine:getSpineGo())
		end

		return self._emitter
	else
		return nil
	end
end

function SpineVoiceAudio:onVoiceStop()
	if self._addAudios then
		for _, audio in pairs(self._addAudios) do
			audio:onDestroy()
		end

		self._addAudios = nil
	end

	TaskDispatcher.cancelTask(self._playAudio, self)
end

return SpineVoiceAudio
