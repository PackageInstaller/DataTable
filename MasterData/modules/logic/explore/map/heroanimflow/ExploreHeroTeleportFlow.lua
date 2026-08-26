-- chunkname: @modules/logic/explore/map/heroanimflow/ExploreHeroTeleportFlow.lua

module("modules.logic.explore.map.heroanimflow.ExploreHeroTeleportFlow", package.seeall)

local ExploreHeroTeleportFlow = class("ExploreHeroTeleportFlow")

function ExploreHeroTeleportFlow:begin(pos)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroTeleportFlow")

	self.toPos = pos

	ViewMgr.instance:openView(ViewName.ExploreBlackView)

	local hero = ExploreController.instance:getMap():getHero()

	hero:stopMoving(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function ExploreHeroTeleportFlow:onOpenViewFinish(viewName)
	if viewName ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	local hero = ExploreController.instance:getMap():getHero()

	hero:stopMoving(true)
	hero:setTilemapPos(self.toPos)
	TaskDispatcher.runDelay(self._delayLoadObj, self, 0.1)
end

function ExploreHeroTeleportFlow:_delayLoadObj()
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function ExploreHeroTeleportFlow:onBlackEnd()
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Teleport)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)

	local map = ExploreController.instance:getMap()
	local hero = map:getHero()

	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroTeleportFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)

	self.toPos = nil
end

function ExploreHeroTeleportFlow:clear()
	TaskDispatcher.cancelTask(self._delayLoadObj, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Teleport)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgr.instance:endBlock("ExploreHeroTeleportFlow")

	self.toPos = nil

	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self.onBlackEnd, self)
end

function ExploreHeroTeleportFlow:isInFlow()
	return not not self.toPos
end

ExploreHeroTeleportFlow.instance = ExploreHeroTeleportFlow.New()

return ExploreHeroTeleportFlow
