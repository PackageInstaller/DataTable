-- chunkname: @modules/audio/AudioParam.lua

module("modules.audio.AudioParam", package.seeall)

local AudioParam = class("AudioParam")

function AudioParam:ctor()
	self:clear()
end

function AudioParam:clear()
	self.loopNum = nil
	self.fadeInTime = nil
	self.fadeOutTime = nil
	self.volume = nil
	self.callback = nil
	self.callbackTarget = nil
end

return AudioParam
