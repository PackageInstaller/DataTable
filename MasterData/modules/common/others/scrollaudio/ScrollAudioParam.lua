-- chunkname: @modules/common/others/scrollaudio/ScrollAudioParam.lua

module("modules.common.others.scrollaudio.ScrollAudioParam", package.seeall)

local ScrollAudioParam = pureTable("ScrollAudioParam")

function ScrollAudioParam:ctor()
	self.scrollDir = ScrollEnum.ScrollDirH
	self.intervalSampleOffset = 0.1
	self.intervalSampleStop = 0.1
	self.startPlayOffset = 0.81
	self.startPlayOffsetDraging = 0.08
	self.stopPlayOffset = 0.8
	self.stopPlayOffsetDraging = 0.075
	self.defaultSfxRepeatTime = 6
	self.speedUpTweenTime = 2
	self.pixelOffsetMoveFactor = 0.03
	self.speedFactor = 0.7
end

return ScrollAudioParam
