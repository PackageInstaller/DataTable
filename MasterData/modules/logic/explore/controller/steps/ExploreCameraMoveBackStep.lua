-- chunkname: @modules/logic/explore/controller/steps/ExploreCameraMoveBackStep.lua

module("modules.logic.explore.controller.steps.ExploreCameraMoveBackStep", package.seeall)

local ExploreCameraMoveBackStep = class("ExploreCameraMoveBackStep", ExploreStepBase)

function ExploreCameraMoveBackStep:onStart()
	self._data.toPos = ExploreMapTriggerController.instance:getMap():getHero():getPos()

	if self._data.keepTime and self._data.keepTime > 0 then
		TaskDispatcher.runDelay(self.beginTween, self, self._data.keepTime)
	else
		self:beginTween()
	end
end

function ExploreCameraMoveBackStep:beginTween()
	if self._data.moveTime then
		self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._data.moveTime, self.moveBack, self.moveBackDone, self)
	else
		ViewMgr.instance:openView(ViewName.ExploreBlackView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	end
end

function ExploreCameraMoveBackStep:onOpenViewFinish(viewName)
	if ViewName.ExploreBlackView ~= viewName then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, self._data.toPos)
	TaskDispatcher.runDelay(self._delayLoadObj, self, 0.1)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function ExploreCameraMoveBackStep:_delayLoadObj()
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function ExploreCameraMoveBackStep:onBlackEnd()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function ExploreCameraMoveBackStep:_onCloseViewFinish(viewName)
	if viewName == ViewName.ExploreBlackView then
		self:onDone()
	end
end

function ExploreCameraMoveBackStep:moveBack(x)
	local pos = self._data.fromPos - self._data.offPos * x

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, pos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, pos)
end

function ExploreCameraMoveBackStep:moveBackDone()
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, self._data.toPos)
	self:onDone()
end

function ExploreCameraMoveBackStep:onDestory()
	ExploreCameraMoveBackStep.super.onDestory(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.MoveCamera)
	TaskDispatcher.cancelTask(self.beginTween, self)
	TaskDispatcher.cancelTask(self._delayLoadObj, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

return ExploreCameraMoveBackStep
