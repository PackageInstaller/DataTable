-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomCanGetResources.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomCanGetResources", package.seeall)

local WaitGuideActionRoomCanGetResources = class("WaitGuideActionRoomCanGetResources", BaseGuideAction)

function WaitGuideActionRoomCanGetResources:onStart(context)
	WaitGuideActionRoomCanGetResources.super.onStart(self, context)

	self._partId = tonumber(self.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function WaitGuideActionRoomCanGetResources:_onEnterOneSceneFinish(sceneType)
	if self:checkGuideLock() then
		return
	end

	if sceneType == SceneType.Room and RoomController.instance:isObMode() then
		local requestLineIdList = RoomProductionHelper.getCanGainLineIdList(self._partId)

		if #requestLineIdList > 0 then
			GuidePriorityController.instance:add(self.guideId, self._satisfyPriority, self, 0.01)
		end
	end
end

function WaitGuideActionRoomCanGetResources:_onOpenViewFinish(viewName)
	if self:checkGuideLock() then
		return
	end

	if viewName == ViewName.RoomInitBuildingView then
		self:onDone(true)
	end
end

function WaitGuideActionRoomCanGetResources:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	GuidePriorityController.instance:remove(self.guideId)
end

function WaitGuideActionRoomCanGetResources:_satisfyPriority()
	self:onDone(true)
end

return WaitGuideActionRoomCanGetResources
