-- chunkname: @modules/logic/explore/controller/steps/ExploreCameraMoveStep.lua

module("modules.logic.explore.controller.steps.ExploreCameraMoveStep", package.seeall)

local ExploreCameraMoveStep = class("ExploreCameraMoveStep", ExploreStepBase)

function ExploreCameraMoveStep:onStart()
	local id = self._data.id

	self.moveTime = self._data.moveTime
	self.keepTime = self._data.keepTime

	local map = ExploreMapTriggerController.instance:getMap()
	local unit = map:getUnit(id)

	if unit then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.MoveCamera)

		local hero = map:getHero()

		self.tarPos = unit:getPos()
		self.startPos = hero:getPos()
		self.offPos = self.tarPos - self.startPos

		local stepData = {
			alwaysLast = true,
			stepType = ExploreEnum.StepType.CameraMoveBack,
			keepTime = self.keepTime
		}

		if self.offPos.sqrMagnitude > 100 then
			ViewMgr.instance:openView(ViewName.ExploreBlackView)
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
		else
			stepData.fromPos = self.tarPos
			stepData.offPos = self.offPos
			stepData.moveTime = self.moveTime
			self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self.moveTime, self.moveToTar, self.moveToTarDone, self)
		end

		ExploreStepController.instance:insertClientStep(stepData)
	else
		logError("Explore not find unit:" .. id)
		self:onDone()
	end
end

function ExploreCameraMoveStep:moveToTar(x)
	local pos = self.startPos + self.offPos * x

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, pos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, pos)
end

function ExploreCameraMoveStep:moveToTarDone()
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, self.tarPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, self.tarPos)
	self:onDone()
end

function ExploreCameraMoveStep:startMoveBack()
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self.moveTime, self.moveBack, self.moveBackDone, self)
end

function ExploreCameraMoveStep:onOpenViewFinish(viewName)
	if viewName ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, self.tarPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, self.tarPos)
	TaskDispatcher.runDelay(self._delayLoadObj, self, 0.1)
end

function ExploreCameraMoveStep:_delayLoadObj()
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function ExploreCameraMoveStep:onBlackEnd()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function ExploreCameraMoveStep:_onCloseViewFinish(viewName)
	if viewName == ViewName.ExploreBlackView then
		self:onDone()
	end
end

function ExploreCameraMoveStep:onDestory()
	ExploreCameraMoveStep.super.onDestory(self)
	TaskDispatcher.cancelTask(self._delayLoadObj, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	TaskDispatcher.cancelTask(self.startMoveBack, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

return ExploreCameraMoveStep
