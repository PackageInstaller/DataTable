-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/audio/AudioPlayer.lua

module(..., package.seeall)

local AudioPlayer = class("AudioPlayer")

function AudioPlayer:ctor()
	self._audioCfg = nil
end

function AudioPlayer:init()
	local go = goutil.create("AudioMixer", false)

	goutil.addComponentOnce(go, typeof(AudioMixerMgr))

	local audioMixer = CommonPreloader.instance:getAsset(CommonResPath.AudioMixer)

	AudioMixerMgr.Instance:SetAudioMixer(audioMixer)
	AudioMixerMgr.Instance:SetMaxAudioSource(10)
	AudioMixerMgr.Instance:SetGroupId("backgound", 0)
	AudioMixerMgr.Instance:SetGroupId("effect_level_1", 1)
	AudioMixerMgr.Instance:SetGroupId("effect_level_2", 2)
	AudioMixerMgr.Instance:SetGroupId("effect_level_3", 3)
	AudioMixerMgr.Instance:SetGroupId("effect_level_4", 4)
	ConfigMgr.instance:requestConfig("audio", self)

	self._currentBgmId = 0
	self._currentOverrideAudioId = 0

	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._onHandleOnApplicationResume, self)
end

function AudioPlayer:handleConfig(name, content)
	if name == "audio" then
		self._audioCfg = content
	end
end

function AudioPlayer:playBgm(bgmId)
	if not bgmId or bgmId <= 0 or self._currentBgmId == bgmId then
		return
	end

	local co = self._audioCfg[bgmId]

	if not co then
		printError("不存在的背景音乐配置,bgmId=", bgmId)

		return
	end

	if isInEditorMode then
		printWarn("AudioPlayer playBgm：", co.resName)
	end

	self._currentBgmId = bgmId

	AudioMixerMgr.Instance:PlayBgm(co.resName, 0)
end

function AudioPlayer:stopBgm()
	if isInEditorMode then
		printWarn("AudioPlayer stopBgm")
	end

	self._currentBgmId = 0

	AudioMixerMgr.Instance:StopBgm()
end

function AudioPlayer:playEffectByPath(path, groupId, callback, callbackSelf)
	if string.nilorempty(path) then
		printError("audio path is nil")

		return
	end

	if isInEditorMode then
		-- block empty
	end

	groupId = groupId or 1

	AudioMixerMgr.Instance:PlayEffect(path, groupId, callback, callbackSelf)
end

function AudioPlayer:playAudioEffect(audioId, callback, callbackSelf)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	self:playEffectByPath(co.resName, co.groupType, callback, callbackSelf)
end

function AudioPlayer:stopAudioEffect(audioId, needInvoke)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	if needInvoke == nil then
		needInvoke = true
	end

	AudioMixerMgr.Instance:StopEffect(co.resName, needInvoke)
end

function AudioPlayer:playOnceEffect(audioId, callback, callbackSelf)
	self:stopAudioEffect(audioId, false)
	self:playAudioEffect(audioId, callback, callbackSelf)
end

function AudioPlayer:playModelAudio(modelId, modelAudioEnum)
	if modelId <= 0 then
		return
	end

	local modelCO = ModelConfig.instance:getModelCO(modelId)
	local audioId = modelCO:getAudioId(modelAudioEnum)

	self:playAudioEffect(audioId)
end

function AudioPlayer:stopModelAudio(modelId, modelAudioEnum)
	if modelId <= 0 then
		return
	end

	local modelCO = ModelConfig.instance:getModelCO(modelId)
	local audioId = modelCO:getAudioId(modelAudioEnum)

	self:stopAudioEffect(audioId)
end

function AudioPlayer:getAudioPath(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	return co.resName
end

function AudioPlayer:playOverrideEffect(audioId, callback, callbackSelf)
	self:stopOverrideEffect(false)

	self._currentOverrideAudioId = audioId

	self:playAudioEffect(audioId, callback, callbackSelf)
end

function AudioPlayer:stopOverrideEffect(needInvoke)
	if needInvoke == nil then
		needInvoke = true
	end

	self:stopAudioEffect(self._currentOverrideAudioId, needInvoke)

	self._currentOverrideAudioId = 0
end

function AudioPlayer:_onHandleOnApplicationPause()
	AudioMixerMgr.Instance.IsBgmMute = true
	AudioMixerMgr.Instance.IsEffectMute = true
end

function AudioPlayer:_onHandleOnApplicationResume()
	AudioMixerMgr.Instance.IsBgmMute = false
	AudioMixerMgr.Instance.IsEffectMute = false
end

AudioPlayer.instance = AudioPlayer.New()

return AudioPlayer
