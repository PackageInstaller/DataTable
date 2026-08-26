-- chunkname: @modules/audio/bgm/AudioBgmData.lua

module("modules.audio.bgm.AudioBgmData", package.seeall)

local AudioBgmData = class("AudioBgmData")

function AudioBgmData:ctor()
	self.layer = nil

	self:clear()
end

function AudioBgmData:clear()
	self.playId = 0
	self.stopId = 0
	self.pauseId = nil
	self.resumeId = nil
	self.switchGroup = nil
	self.switchState = nil
end

function AudioBgmData:setSwitch()
	if self.switchGroup and self.switchState then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(self.switchGroup), AudioMgr.instance:getIdFromString(self.switchState))
	end
end

return AudioBgmData
