-- chunkname: @modules/logic/fight/system/work/FightWorkRefreshFightAfterCrash.lua

module("modules.logic.fight.system.work.FightWorkRefreshFightAfterCrash", package.seeall)

local FightWorkRefreshFightAfterCrash = class("FightWorkRefreshFightAfterCrash", FightWorkItem)

function FightWorkRefreshFightAfterCrash:onConstructor()
	return
end

function FightWorkRefreshFightAfterCrash:onStart()
	FightDataHelper.stateMgr.dealingCrash = true

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkFunction, FightGameMgr.playMgr.onForceReleasePlayFlow, FightGameMgr.playMgr)
	flow:registWork(FightWorkFunction, self.refreshPerformanceData, self)

	for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		if isTypeOf(entity, FightEntitySub) then
			FightGameMgr.entityMgr:delEntity(entityId)
		end
	end

	flow:registWork(FightWorkFunction, FightGameMgr.entityMgr.newAllEntityAndRemoveDiff, FightGameMgr.entityMgr)
	flow:registWork(FightWorkFunction, ViewMgr.instance.closeView, ViewMgr.instance, ViewName.FightSkillSelectView, true)
	flow:registWork(FightWorkFunction, ViewMgr.instance.closeView, ViewMgr.instance, ViewName.FightView, true)
	flow:registWork(FightWorkFunction, ViewDestroyMgr.instance.destroyImmediately, ViewDestroyMgr.instance)
	flow:registWork(FightWorkOpenView, ViewName.FightSkillSelectView)
	flow:registWork(FightWorkOpenView, ViewName.FightView)
	flow:registWork(FightWorkFunction, self.refreshActPoint, self)
	flow:registWork(FightWorkSendEvent, FightEvent.ForceRefreshOperationArea)
	flow:registWork(FightWorkSendEvent, FightEvent.BeforeEnterStepBehaviour)
	flow:registWork(FightWorkSendEvent, FightEvent.OnStartSequenceFinish)
	flow:registFinishCallback(self.onFlowFinish, self)
	self:playWorkAndDone(flow)
end

function FightWorkRefreshFightAfterCrash:onFlowFinish()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)

	for entityId, entity in pairs(FightGameMgr.entityMgr.entityDic) do
		if entity.nameUIVisible then
			entity.nameUIVisible:ctor(entity)
		end

		if entity.nameUI and entity.nameUI._uiGO then
			entity.nameUI:setActive(true)

			entity.nameUI._nameUIVisible = true

			entity.nameUI:updateUI()
			entity.nameUI:resetHp()
		end
	end
end

function FightWorkRefreshFightAfterCrash:refreshActPoint()
	FightDataHelper.operationDataMgr:applyNextRoundActPoint()
end

function FightWorkRefreshFightAfterCrash:refreshPerformanceData()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local sideDic = FightDataMgr.instance.entityMgr.sideDic

	for side, dic in pairs(sideDic) do
		for listType, list in pairs(dic) do
			tabletool.clear(list)
		end
	end

	FightDataUtil.coverData(FightLocalDataMgr.instance.entityMgr, FightDataMgr.instance.entityMgr, {
		dataMgr = true,
		sideDic = true,
		__cname = true
	})

	for side, dic in pairs(FightLocalDataMgr.instance.entityMgr.sideDic) do
		for listType, list in pairs(dic) do
			for i, entityData in ipairs(list) do
				table.insert(sideDic[side][listType], FightDataMgr.instance.entityMgr.entityDataDic[entityData.id])
			end
		end
	end

	FightDataUtil.coverData(FightLocalDataMgr.instance.handCardMgr.handCard, FightDataMgr.instance.handCardMgr.handCard)

	FightDataHelper.operationDataMgr.actPoint = 0
	FightDataHelper.operationDataMgr.extraMoveAct = 0
	FightModel.instance.power = roundData.power
	FightModel.instance._curWaveId = FightLocalDataMgr.instance.fieldMgr.curWave
	FightModel.instance._curRoundId = FightLocalDataMgr.instance.fieldMgr.curRound
end

function FightWorkRefreshFightAfterCrash:onDestructor()
	FightDataHelper.stateMgr.dealingCrash = false
end

return FightWorkRefreshFightAfterCrash
