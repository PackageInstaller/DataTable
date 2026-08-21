-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/controller/StoryVoiceController.lua

module("logic.extensions.story.controller.StoryVoiceController", package.seeall)

local M = class("StoryVoiceController", BaseController)

function M:ctor()
	M.super.ctor(self)
	self:_resetParam()
end

function M:_resetParam()
	self._playVoiceType = nil
	self._playingVoice = nil
	self._playingUId = nil
	self._playingBgsUrls = {}
end

function M:playVoice(t, voiceUId, voiceUrl, voiceVolume)
	if not t or GameUtils.isEmptyString(voiceUrl) then
		printError("无法播放voice,type or voice error", tostring(type), tostring(voiceUrl))

		return
	end

	self:stopPlayingVoice()

	self._isPlaying = true
	self._playVoiceType = t
	self._playingVoice = voiceUrl
	self._playingUId = voiceUId

	print("volume", voiceVolume)

	Astral.ToLuaFramework.AudioMgr.Instance.EffectVolume = voiceVolume or 1

	Astral.ToLuaFramework.AudioMgr.Instance:PlayEffectWithFinish(voiceUrl, self.stopPlayingVoice, self)
	StoryDispatcher:dispatchEvent(PlotNotifyName.PlotPlayVoice, t, voiceUrl, voiceUId)
end

function M:stopPlayingVoice()
	if self._isPlaying then
		self._isPlaying = false

		Astral.ToLuaFramework.AudioMgr.Instance:StopEffect(self._playingVoice)
		StoryDispatcher:dispatchEvent(PlotNotifyName.PlotStopVoice, self._playVoiceType, self._playingVoice, self._playingUId)
	end

	self:_resetParam()
end

function M:_logPrint(...)
	local _str = table.concat({
		...
	}, " ")

	print(_str)
end

function M:getPlayingVoice()
	return self._playingUId, self._playVoiceType, self._playingVoice
end

function M:checkVoicePlaying(t, uid, voiceUrl)
	return t and uid and not GameUtils.isEmptyString(voiceUrl) and t == self._playVoiceType and uid == self._playingUId and voiceUrl == self._playingVoice
end

function M:playEffectAudio(url, voiceVolume)
	if GameUtils.isEmptyString(url) then
		printError("无法播放空url音效")

		return
	end

	local uid = UIDUtil.getUID()

	self._playingBgsUrls[uid] = url

	print("volume", voiceVolume)

	Astral.ToLuaFramework.AudioMgr.Instance.EffectVolume = voiceVolume or 1

	Astral.ToLuaFramework.AudioMgr.Instance:PlayEffectWithFinish(url, function()
		self._playingBgsUrls[uid] = nil
	end, nil)

	return uid
end

function M:stopEffectAudio(url)
	if GameUtils.isEmptyString(url) then
		return
	end

	local idList = {}

	for key, value in pairs(self._playingBgsUrls) do
		idList[#idList + 1] = key
	end

	for i, v in ipairs(idList) do
		local efxName = self._playingBgsUrls[v]

		self._playingBgsUrls[v] = nil

		Astral.ToLuaFramework.AudioMgr.Instance:StopEffect(efxName)
	end
end

function M:stopAllEffectAudio()
	for k, efxName in pairs(self._playingBgsUrls) do
		Astral.ToLuaFramework.AudioMgr.Instance:StopEffect(efxName)
	end

	self._playingBgsUrls = {}
end

M.instance = M.New()

return M
