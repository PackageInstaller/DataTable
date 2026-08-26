-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomTransport.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomTransport", package.seeall)

local WaitGuideActionRoomTransport = class("WaitGuideActionRoomTransport", BaseGuideAction)

function WaitGuideActionRoomTransport:onStart(context)
	WaitGuideActionRoomTransport.super.onStart(self, context)

	self._modeRequire = 2

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._checkDone, self)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._checkDone, self)

	self._goStepId = tonumber(self.actionParam)
end

function WaitGuideActionRoomTransport:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkDone, self)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self._checkDone, self)
end

function WaitGuideActionRoomTransport:_checkDone()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.Room then
		local curMode = RoomModel.instance:getGameMode()
		local isRightMode = false

		isRightMode = self._modeRequire and curMode == self._modeRequire or RoomController.instance:isEditMode()

		if isRightMode then
			self:checkCondition()
		end
	end
end

function WaitGuideActionRoomTransport:checkCondition()
	if GuideActionCondition.checkRoomTransport() then
		local guideMO = GuideModel.instance:getById(self.guideId)

		if guideMO then
			guideMO.currStepId = self._goStepId - 1
		end

		self:onDone(true)
	end
end

return WaitGuideActionRoomTransport
