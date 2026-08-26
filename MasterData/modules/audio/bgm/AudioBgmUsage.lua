-- chunkname: @modules/audio/bgm/AudioBgmUsage.lua

module("modules.audio.bgm.AudioBgmUsage", package.seeall)

local AudioBgmUsage = class("AudioBgmUsage")

function AudioBgmUsage:ctor()
	self.layerList = nil
	self.type = nil
	self.typeParam = nil
	self.queryFunc = nil
	self.queryFuncTarget = nil
	self.clearPauseBgm = nil
end

function AudioBgmUsage:containBgm(layer)
	return tabletool.indexOf(self.layerList, layer)
end

function AudioBgmUsage:setClearPauseBgm(value)
	self.clearPauseBgm = value
end

function AudioBgmUsage:getBgmLayer()
	if #self.layerList == 1 then
		return self.layerList[1]
	end

	if self.queryFunc then
		return self.queryFunc(self.queryFuncTarget, self)
	end
end

return AudioBgmUsage
