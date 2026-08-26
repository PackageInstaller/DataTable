-- chunkname: @modules/logic/explore/controller/steps/ExploreShowAreaStep.lua

module("modules.logic.explore.controller.steps.ExploreShowAreaStep", package.seeall)

local ExploreShowAreaStep = class("ExploreShowAreaStep", ExploreStepBase)

function ExploreShowAreaStep:onInit()
	self._unLockAreas = self._data.showAreas

	if #self._unLockAreas ~= 1 then
		if #self._unLockAreas > 1 then
			logError("暂不支持多区域同时解锁")
		end

		return
	end

	self.areaGo = ExploreController.instance:getMap():getContainRootByAreaId(self._unLockAreas[1]).go
	self._loader = MultiAbLoader.New()

	self._loader:addPath(string.format("modules/explore/camera_anim/%d_%d.controller", ExploreModel.instance:getMapId(), self._unLockAreas[1]))
	self._loader:startLoad(self._loadedFinish, self)
end

function ExploreShowAreaStep:onStart()
	if #self._unLockAreas ~= 1 then
		self:onDone()

		return
	end

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.ShowArea)
	gohelper.setActive(self.areaGo, false)

	ExploreModel.instance.unLockAreaIds[self._unLockAreas[1]] = true

	ExploreController.instance:dispatchEvent(ExploreEvent.AreaShow)
end

function ExploreShowAreaStep:_loadedFinish()
	if not self._data then
		return
	end

	gohelper.setActive(self.areaGo, true)

	local ctrl = self._loader:getFirstAssetItem():GetResource()

	self._anim = gohelper.onceAddComponent(self.areaGo, typeof(UnityEngine.Animator))
	self._anim.runtimeAnimatorController = ctrl

	local info = self._anim:GetCurrentAnimatorStateInfo(0)

	TaskDispatcher.runDelay(self._onAnimDone, self, info.length)
end

function ExploreShowAreaStep:_onAnimDone()
	self:onDone()
end

function ExploreShowAreaStep:onDestory()
	TaskDispatcher.cancelTask(self._onAnimDone, self)

	self.areaGo = nil

	if self._anim then
		gohelper.destroy(self._anim)

		self._anim = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.ShowArea)
	ExploreShowAreaStep.super.onDestory(self)
end

return ExploreShowAreaStep
