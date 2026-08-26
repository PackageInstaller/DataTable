-- chunkname: @modules/logic/explore/map/tree/ExploreMapTree.lua

module("modules.logic.explore.map.tree.ExploreMapTree", package.seeall)

local ExploreMapTree = class("ExploreMapTree")

function ExploreMapTree:ctor()
	self.root = nil
	self.checkMode = ExploreEnum.SceneCheckMode.Planes

	if SLFramework.FrameworkSettings.IsEditor then
		ZProj.ExploreHelper.InitDrawBound()
		TaskDispatcher.runRepeat(self.drawBound, self, 1e-05)
	end
end

function ExploreMapTree:setup(config, preloadComp)
	self.root = ExploreMapTreeNode.New(config, preloadComp)
	self.camera = CameraMgr.instance:getMainCamera()
end

function ExploreMapTree:triggerMove(showRage, showIdDict)
	if self.checkMode == ExploreEnum.SceneCheckMode.Planes then
		local fov = self.camera.fieldOfView + 2
		local asp = self.camera.aspect
		local farClipPlane = 25
		local nearClipPlane = 0.01

		ZProj.ExploreHelper.RebuildFrustumPlanes(self.camera, farClipPlane, nearClipPlane, fov, asp)
	end

	if self.checkMode ~= ExploreEnum.SceneCheckMode.Rage then
		showRage.z = 6
		showRage.w = 6
	end

	self.root:triggerMove(showRage, self.camera, self.checkMode, showIdDict)
end

function ExploreMapTree:drawBound()
	ZProj.ExploreHelper.ResetBoundsList()
	self.root:drawBound()
end

function ExploreMapTree:onDestroy()
	TaskDispatcher.cancelTask(self.drawBound, self)

	if self.root then
		self.root:onDestroy()

		self.root = nil
	end

	self.camera = nil
end

return ExploreMapTree
