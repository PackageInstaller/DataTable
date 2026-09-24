-- chunkname: @modules/logic/fight/system/work/FightPreloadTimelineAssetItem.lua

module("modules.logic.fight.system.work.FightPreloadTimelineAssetItem", package.seeall)

local FightPreloadTimelineAssetItem = class("FightPreloadTimelineAssetItem", FightBaseClass)

function FightPreloadTimelineAssetItem:onConstructor(timelineName, fightStepData)
	self.timelineName = FightHelper.detectReplaceTimeline(timelineName, fightStepData)
	self.fightStepData = fightStepData
end

function FightPreloadTimelineAssetItem:startLoad()
	local entityData = FightLocalDataMgr.instance.entityMgr:getById(self.fightStepData.fromId)

	entityData = entityData or FightDataMgr.instance.entityMgr:getById(self.fightStepData.fromId)

	if not entityData then
		return
	end

	local loaderComp = self:addComponent(FightLoaderComponent)
	local work = self:com_registWork(FightWorkTimelineAssetItem, loaderComp, entityData, self.timelineName, self.fightStepData)

	work:start()
end

return FightPreloadTimelineAssetItem
