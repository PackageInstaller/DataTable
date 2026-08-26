-- chunkname: @modules/logic/explore/map/heroanimflow/ExploreHeroResetFlow.lua

module("modules.logic.explore.map.heroanimflow.ExploreHeroResetFlow", package.seeall)

local ExploreHeroResetFlow = class("ExploreHeroResetFlow")

function ExploreHeroResetFlow:begin(sourceUnitId)
	self.sourceUnitId = sourceUnitId
	self._isReset = true

	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroResetFlow")
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
end

function ExploreHeroResetFlow:onOpenViewFinish(viewName)
	if viewName ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	local map = ExploreController.instance:getMap()
	local hero = map:getHero()
	local sourceUnit = map:getUnit(self.sourceUnitId)

	if sourceUnit then
		sourceUnit:tryTrigger()

		hero.dir = sourceUnit.mo.targetDir

		hero:setRotate(0, sourceUnit.mo.targetDir, 0)
		hero:setTilemapPos({
			x = sourceUnit.mo.targetX,
			y = sourceUnit.mo.targetY
		})
	end

	self.sourceUnitId = nil

	TaskDispatcher.runDelay(self._delayLoadObj, self, 0.1)
end

function ExploreHeroResetFlow:_delayLoadObj()
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self.onSceneObjLoaded, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function ExploreHeroResetFlow:onSceneObjLoaded()
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onSceneObjLoaded, self)
	self:checkMsgRecv()
end

function ExploreHeroResetFlow:checkMsgRecv()
	if not ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.BeginInteract) then
		ExploreController.instance:registerCallback(ExploreEvent.UnitInteractEnd, self.onBlackEnd, self)
	else
		self:onBlackEnd()
	end
end

function ExploreHeroResetFlow:onBlackEnd()
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitInteractEnd, self.onBlackEnd, self)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroResetFlow")
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)
	ExploreController.instance:getMapPipe():initColors(true)

	self._isReset = false
end

function ExploreHeroResetFlow:isReseting()
	return self._isReset
end

function ExploreHeroResetFlow:clear()
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroResetFlow")
	TaskDispatcher.cancelTask(self._delayLoadObj, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitInteractEnd, self.onBlackEnd, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onSceneObjLoaded, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	self._isReset = false

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)
end

ExploreHeroResetFlow.instance = ExploreHeroResetFlow.New()

return ExploreHeroResetFlow
