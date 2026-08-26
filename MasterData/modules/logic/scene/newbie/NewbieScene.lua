-- chunkname: @modules/logic/scene/newbie/NewbieScene.lua

module("modules.logic.scene.newbie.NewbieScene", package.seeall)

local NewbieScene = class("NewbieScene", BaseScene)

function NewbieScene:_createAllComps()
	return
end

function NewbieScene:onClose()
	NewbieScene.super.onClose(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
	TaskDispatcher.cancelTask(self._resetScenePos, self)
	self:_removeEvents()
end

function NewbieScene:onPrepared()
	NewbieScene.super.onPrepared(self)

	if self.level then
		local go = self.level:getSceneGo()

		if gohelper.isNil(go) then
			return
		end

		self:_moveScene(0.5)

		if ViewMgr.instance:isOpenFinish(ViewName.StoryView) then
			self:_onOpenFinish(ViewName.StoryView)

			return
		end

		self:_addEvents()
	end
end

function NewbieScene:_addEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
	MainController.instance:registerCallback(MainEvent.GuideSetDelayTime, self._onGuideSetDelayTime, self)
end

function NewbieScene:_removeEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinish, self)
	MainController.instance:unregisterCallback(MainEvent.GuideSetDelayTime, self._onGuideSetDelayTime, self)
end

function NewbieScene:_onGuideSetDelayTime(time)
	local go = self.level:getSceneGo()

	if gohelper.isNil(go) then
		return
	end

	self:_moveScene(time)
	TaskDispatcher.runDelay(self._resetScenePos, self, 2)
end

function NewbieScene:_moveScene(time)
	local go = self.level:getSceneGo()

	if gohelper.isNil(go) then
		return
	end

	transformhelper.setLocalPosXY(go.transform, 0, 100)

	self._delayTime = tonumber(time)
end

function NewbieScene:_onOpenFinish(viewName)
	if viewName == ViewName.StoryView and self._delayTime then
		TaskDispatcher.cancelTask(self._resetScenePos, self)
		TaskDispatcher.runDelay(self._resetScenePos, self, self._delayTime)

		self._delayTime = nil
	end
end

function NewbieScene:_resetScenePos()
	local go = self.level:getSceneGo()

	if gohelper.isNil(go) then
		return
	end

	transformhelper.setLocalPosXY(go.transform, 0, 0)
end

function NewbieScene:onStart(sceneId, levelId)
	if not DungeonModel.instance:hasPassLevel(10003) then
		self:onPrepared()
	else
		if not self._isAddComps then
			self._isAddComps = true

			self:_addComp("level", NewbieSceneLevelComp)
			self:_addComp("camera", CommonSceneCameraComp)
			self:_addComp("yearAnimation", MainSceneYearAnimationComp)

			for _, comp in ipairs(self._allComps) do
				if comp.onInit then
					comp:onInit()
				end
			end

			self.yearAnimation.forcePlayAnimation = true
		end

		NewbieScene.super:onStart(sceneId, 10101)
	end
end

return NewbieScene
