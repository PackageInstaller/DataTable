-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlChangeVolume.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlChangeVolume", package.seeall)

local NecrologistStoryControlChangeVolume = class("NecrologistStoryControlChangeVolume", NecrologistStoryControlMgrItem)

function NecrologistStoryControlChangeVolume:onPlayControl()
	self:changeVolume()
	self:onPlayControlFinish()
end

function NecrologistStoryControlChangeVolume:changeVolume()
	local attr = string.split(self.controlParam, "#")
	local volume = (tonumber(attr[2]) or 1) * 100
	local transitionTime = tonumber(attr[3]) or 0

	self.audioId = tonumber(attr[1])

	if self.audioId then
		AudioEffectMgr.instance:setVolume(self.audioId, volume, transitionTime)
	end
end

function NecrologistStoryControlChangeVolume:onDestory()
	NecrologistStoryControlChangeVolume.super.onDestory(self)
end

return NecrologistStoryControlChangeVolume
