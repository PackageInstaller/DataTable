-- chunkname: @modules/logic/rouge2/map/map/Rouge2_PathSelectMap.lua

module("modules.logic.rouge2.map.map.Rouge2_PathSelectMap", package.seeall)

local Rouge2_PathSelectMap = class("Rouge2_PathSelectMap", Rouge2_BaseMap)

function Rouge2_PathSelectMap:initMap()
	self.mapTransform = self.mapGo.transform

	local cameraSize = Rouge2_MapConfig.instance:getPathSelectInitCameraSize()

	Rouge2_MapModel.instance:setCameraSize(cameraSize)
end

function Rouge2_PathSelectMap:createMap()
	self.actorComp = nil

	Rouge2_PathSelectMap.super.createMap(self)
	TaskDispatcher.runDelay(self.focusToTarget, self, Rouge2_MapEnum.PathSelectMapWaitTime)

	self.openViewDone = ViewMgr.instance:isOpen(ViewName.Rouge2_MapView)

	if not ViewMgr.instance:isOpen(ViewName.Rouge2_MapView) then
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	end
end

function Rouge2_PathSelectMap:onOpenView(viewName)
	if viewName == ViewName.Rouge2_MapView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)

		self.openViewDone = true

		self:_focusToTarget()
	end
end

function Rouge2_PathSelectMap:focusToTarget()
	self.delayDone = true

	self:_focusToTarget()
end

function Rouge2_PathSelectMap:_focusToTarget()
	if not self.delayDone or not self.openViewDone then
		return
	end

	self:clearTween()
	self:onMovingDone()
end

function Rouge2_PathSelectMap:onMovingDone()
	self.movingTweenId = nil

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onPathSelectMapFocusDone)
end

function Rouge2_PathSelectMap:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	self.movingTweenId = nil
end

function Rouge2_PathSelectMap:destroy()
	self:clearTween()
	TaskDispatcher.cancelTask(self.focusToTarget, self)
	Rouge2_PathSelectMap.super.destroy(self)
end

return Rouge2_PathSelectMap
