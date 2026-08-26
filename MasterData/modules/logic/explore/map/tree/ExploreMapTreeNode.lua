-- chunkname: @modules/logic/explore/map/tree/ExploreMapTreeNode.lua

module("modules.logic.explore.map.tree.ExploreMapTreeNode", package.seeall)

local ExploreMapTreeNode = class("ExploreMapTreeNode")

function ExploreMapTreeNode:ctor(config, preloadComp)
	self.preloadComp = preloadComp
	self.bound = Bounds.New(Vector3.New(config.bound.center[1], config.bound.center[2], config.bound.center[3]), Vector3.New(config.bound.size[1], 4, config.bound.size[3]))
	self._drawBound = Bounds.New(Vector3.New(config.bound.center[1], config.bound.center[2], config.bound.center[3]), Vector3.New(config.bound.size[1], 2, config.bound.size[3]))
	self.centerX = self.bound.center.x
	self.centerZ = self.bound.center.z
	self.extentsX = self.bound.extents.x
	self.extentsZ = self.bound.extents.z
	self.childList = {}
	self.isShow = false

	for i, v in ipairs(config.child) do
		local child = ExploreMapTreeNode.New(config.child[i], preloadComp)

		table.insert(self.childList, child)
	end

	self.objList = {}

	for i, v in ipairs(config.objList) do
		table.insert(self.objList, config.objList[i])
	end
end

function ExploreMapTreeNode:triggerMove(showRage, camera, checkMode, showIdDict)
	self.isShow = true

	for i, v in ipairs(self.objList) do
		showIdDict[v] = 1
	end

	for i, v in ipairs(self.childList) do
		if self.childList[i]:checkBound(showRage, camera, checkMode) then
			self.childList[i]:triggerMove(showRage, camera, checkMode, showIdDict)
		else
			self.childList[i]:hide()
		end
	end
end

function ExploreMapTreeNode:hide()
	if self.isShow then
		for i, v in ipairs(self.childList) do
			self.childList[i]:hide()
		end
	end

	self.isShow = false
end

function ExploreMapTreeNode:checkBound(showRage, camera, checkMode)
	if self:_checkRage(showRage) then
		return true
	elseif checkMode == ExploreEnum.SceneCheckMode.Camera then
		return self:_checkCamera(camera)
	elseif checkMode == ExploreEnum.SceneCheckMode.Planes then
		return self:_checkInplanes(camera)
	else
		return false
	end
end

function ExploreMapTreeNode:_checkCamera(camera)
	return ZProj.ExploreHelper.CheckBoundIsInCamera(self.bound, camera)
end

function ExploreMapTreeNode:_checkInplanes(camera)
	return ZProj.ExploreHelper.CheckBoundIsInplanes(self.bound, camera)
end

function ExploreMapTreeNode:_checkRage(showRage)
	local distanceX = math.abs(self.centerX - showRage.x)
	local distanceZ = math.abs(self.centerZ - showRage.y)
	local halfX = math.abs(self.extentsX + showRage.z)
	local halfZ = math.abs(self.extentsZ + showRage.w)

	return distanceX <= halfX and distanceZ <= halfZ
end

function ExploreMapTreeNode:drawBound()
	if self.isShow then
		for i, v in ipairs(self.childList) do
			self.childList[i]:drawBound()
		end

		ZProj.ExploreHelper.DrawBound(self._drawBound)
	end
end

function ExploreMapTreeNode:onDestroy()
	self.preloadComp = nil

	if self.childList then
		for _, v in pairs(self.childList) do
			v:onDestroy()
		end
	end

	self.childList = nil
	self.objList = nil
end

return ExploreMapTreeNode
