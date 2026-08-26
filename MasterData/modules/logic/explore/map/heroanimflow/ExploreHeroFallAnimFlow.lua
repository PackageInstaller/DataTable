-- chunkname: @modules/logic/explore/map/heroanimflow/ExploreHeroFallAnimFlow.lua

module("modules.logic.explore.map.heroanimflow.ExploreHeroFallAnimFlow", package.seeall)

local ExploreHeroFallAnimFlow = class("ExploreHeroFallAnimFlow")

function ExploreHeroFallAnimFlow:begin(pos, sourceUnitId)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroFallAnimFlow")
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)

	self.toPos = pos
	self.sourceUnitId = sourceUnitId

	local map = ExploreController.instance:getMap()

	map:setMapStatus(ExploreEnum.MapStatus.Normal)

	for k, v in pairs(map:getAllUnit()) do
		if v:getUnitType() == ExploreEnum.ItemType.Spike then
			v:pauseTriggerSpike()
		end
	end

	local hero = map:getHero()

	hero:stopMoving(true)
	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Fall)
	hero:setTrOffset(nil, hero.trans.position + Vector3(0, -0.5, 0), nil, self.onHeroFallEnd, self)
end

function ExploreHeroFallAnimFlow:onHeroFallEnd()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
end

function ExploreHeroFallAnimFlow:onOpenViewFinish(viewName)
	if viewName ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	local map = ExploreController.instance:getMap()
	local hero = map:getHero()

	for k, v in pairs(map:getAllUnit()) do
		if v:getUnitType() == ExploreEnum.ItemType.Spike then
			v:beginTriggerSpike()
		end
	end

	local sourceUnit = map:getUnit(self.sourceUnitId)

	if sourceUnit then
		hero.dir = sourceUnit.mo.heroDir

		hero:setRotate(0, sourceUnit.mo.heroDir, 0)
	end

	self.sourceUnitId = nil
	hero._displayTr.localPosition = Vector3.zero

	hero:setTilemapPos(self.toPos)
	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)

	self.toPos = nil

	TaskDispatcher.runDelay(self._delayLoadObj, self, 0.1)
end

function ExploreHeroFallAnimFlow:_delayLoadObj()
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function ExploreHeroFallAnimFlow:onBlackEnd()
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)

	local map = ExploreController.instance:getMap()
	local hero = map:getHero()

	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroFallAnimFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Spike)
end

function ExploreHeroFallAnimFlow:clear()
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._delayLoadObj, self)
	UIBlockMgr.instance:endBlock("ExploreHeroFallAnimFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)

	self.toPos = nil
	self.sourceUnitId = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Spike)
end

ExploreHeroFallAnimFlow.instance = ExploreHeroFallAnimFlow.New()

return ExploreHeroFallAnimFlow
