-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterRoomOrOpenView.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterRoomOrOpenView", package.seeall)

local WaitGuideActionEnterRoomOrOpenView = class("WaitGuideActionEnterRoomOrOpenView", BaseGuideAction)

function WaitGuideActionEnterRoomOrOpenView:onStart(context)
	WaitGuideActionEnterRoomOrOpenView.super.onStart(self, context)

	local params = string.split(self.actionParam, "#")

	self._modeRequire = tonumber(params[1])
	self._needEnterToTrigger = params[2] == "1"
	self._viewName = params[3]

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._checkDone, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._checkDone, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)

	if not self._needEnterToTrigger then
		self:_checkDone()
	end
end

function WaitGuideActionEnterRoomOrOpenView:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkDone, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self._checkDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	GuidePriorityController.instance:remove(self.guideId)
end

function WaitGuideActionEnterRoomOrOpenView:_onOpenView(viewName)
	if viewName == self._viewName then
		self:_checkDone()
	end
end

function WaitGuideActionEnterRoomOrOpenView:_checkDone()
	if self:checkGuideLock() then
		return
	end

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		local curMode = RoomModel.instance:getGameMode()
		local isRightMode = false

		isRightMode = self._modeRequire and curMode == self._modeRequire or RoomController.instance:isEditMode()

		if isRightMode then
			GuidePriorityController.instance:add(self.guideId, self._satisfyPriority, self, 0.01)
		end
	end
end

function WaitGuideActionEnterRoomOrOpenView:_satisfyPriority()
	self:onDone(true)
end

return WaitGuideActionEnterRoomOrOpenView
