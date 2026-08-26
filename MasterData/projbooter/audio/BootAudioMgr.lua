-- chunkname: @projbooter/audio/BootAudioMgr.lua

module("projbooter.audio.BootAudioMgr", package.seeall)

local BootAudioMgr = class("BootAudioMgr")

function BootAudioMgr:ctor()
	return
end

function BootAudioMgr:init(onInited, onInitedObj)
	self.csharpInst = ZProj.AudioManager.Instance

	self.csharpInst:BootInit(onInited, onInitedObj)
end

function BootAudioMgr:_onInited()
	logNormal("BootAudioMgr._onInited -----------")
end

function BootAudioMgr:dispose()
	self.csharpInst:BootDispose()
end

function BootAudioMgr:trigger(eventName, bankName)
	self.csharpInst:TriggerEvent(eventName, bankName)
end

BootAudioMgr.instance = BootAudioMgr.New()

return BootAudioMgr
