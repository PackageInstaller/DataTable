-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionOpenDungeonMapView.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenDungeonMapView", package.seeall)

local WaitGuideActionOpenDungeonMapView = class("WaitGuideActionOpenDungeonMapView", BaseGuideAction)

function WaitGuideActionOpenDungeonMapView:onStart(context)
	WaitGuideActionOpenDungeonMapView.super.onStart(self, context)

	self._viewName = ViewName.DungeonMapView

	if not ViewMgr.instance:isOpen(self._viewName) then
		self:onDone(true)

		return
	end

	local container = ViewMgr.instance:getContainer(self._viewName)
	local mapSceneView = container:getMapScene()
	local sceneGo = mapSceneView and mapSceneView:getSceneGo()

	if not gohelper.isNil(sceneGo) then
		self:onDone(true)

		return
	end

	DungeonController.instance:registerCallback(DungeonEvent.OnShowMap, self._onShowMap, self)

	local timeoutSecond = 2

	TaskDispatcher.runDelay(self._delayDone, self, timeoutSecond)
end

function WaitGuideActionOpenDungeonMapView:_onShowMap()
	self:clearWork()
	self:onDone(true)
end

function WaitGuideActionOpenDungeonMapView:_delayDone()
	self:clearWork()
	self:onDone(true)
end

function WaitGuideActionOpenDungeonMapView:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnShowMap, self._onShowMap, self)
end

return WaitGuideActionOpenDungeonMapView
