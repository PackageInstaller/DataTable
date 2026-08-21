-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/AudioListenerMgr.lua

module("logic.common.audio.AudioListenerMgr", package.seeall)

local AudioListenerMgr = class("AudioListenerMgr")

AudioListenerMgr.Type_AudioListener = typeof(UnityEngine.AudioListener)

function AudioListenerMgr:ctor()
	local cameraTarget = CameraTargetMgr.instance:getUICameraTarget()
	local goUICamera = cameraTarget:getGO()

	self._defaultAudioListener = goutil.addComponentOnce(goUICamera, AudioListenerMgr.Type_AudioListener)
end

function AudioListenerMgr:init()
	return
end

function AudioListenerMgr:setDefaultAudioListener(enabled)
	self._defaultAudioListener.enabled = enabled
end

AudioListenerMgr.instance = AudioListenerMgr.New()

return AudioListenerMgr
