-- chunkname: @modules/spine/SpineFpsMgr.lua

module("modules.spine.SpineFpsMgr", package.seeall)

local SpineFpsMgr = class("SpineFpsMgr")
local DefaultFps = 30

SpineFpsMgr.FightScene = "FightScene"
SpineFpsMgr.Story = "Story"
SpineFpsMgr.Module = {
	[SpineFpsMgr.FightScene] = 60,
	[SpineFpsMgr.Story] = 60
}

function SpineFpsMgr:ctor()
	self._moduleKey2FpsDict = {}
end

function SpineFpsMgr:set(moduleKey)
	local fps = SpineFpsMgr.Module[moduleKey]

	if fps then
		self._moduleKey2FpsDict[moduleKey] = fps

		self:_updateFps()
	else
		logError("key not in SpineFpsMgr.Module: " .. moduleKey)
	end
end

function SpineFpsMgr:remove(moduleKey)
	if self._moduleKey2FpsDict[moduleKey] then
		self._moduleKey2FpsDict[moduleKey] = nil

		self:_updateFps()
	end
end

function SpineFpsMgr:_updateFps()
	local targetFps = DefaultFps

	for _, fps in pairs(self._moduleKey2FpsDict) do
		if targetFps < fps then
			targetFps = fps
		end
	end

	Spine.Unity.SkeletonAnimation.SetTargetFps(targetFps)
	Spine.Unity.SkeletonGraphic.SetTargetFps(targetFps)
end

SpineFpsMgr.instance = SpineFpsMgr.New()

return SpineFpsMgr
