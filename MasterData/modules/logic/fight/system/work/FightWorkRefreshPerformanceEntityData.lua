-- chunkname: @modules/logic/fight/system/work/FightWorkRefreshPerformanceEntityData.lua

module("modules.logic.fight.system.work.FightWorkRefreshPerformanceEntityData", package.seeall)

local FightWorkRefreshPerformanceEntityData = class("FightWorkRefreshPerformanceEntityData", FightWorkItem)

function FightWorkRefreshPerformanceEntityData:onStart(context)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		self:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		self:onDone(true)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		self:onDone(true)

		return
	end

	if FightDataHelper.stateMgr.isReplay then
		local version = FightModel.instance:getVersion()

		if version >= 4 then
			self:_refreshPerformanceData()
		end

		self:onDone(true)

		return
	end

	self:_refreshPerformanceData(true)
	self:onDone(true)
end

function FightWorkRefreshPerformanceEntityData:_refreshPerformanceData()
	local filterCompareKey = FightWorkCompareServerEntityData.filterCompareKey
	local costomCompareFunc = FightWorkCompareServerEntityData.costomCompareFunc
	local localEntityMODid = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()

	for k, localEntityMO in pairs(localEntityMODid) do
		if not localEntityMO:isStatusDead() then
			local entityId = localEntityMO.id
			local performanceEntityMO = FightDataHelper.entityMgr:getById(entityId)
			local diff, diffTab = FightDataUtil.findDiff(localEntityMO, performanceEntityMO, filterCompareKey, costomCompareFunc)

			if diff then
				FightEntityDataHelper.copyEntityMO(localEntityMO, performanceEntityMO)
				FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, entityId)
			end
		end
	end
end

function FightWorkRefreshPerformanceEntityData:clearWork()
	return
end

return FightWorkRefreshPerformanceEntityData
