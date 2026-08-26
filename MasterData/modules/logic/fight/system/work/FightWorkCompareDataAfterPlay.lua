-- chunkname: @modules/logic/fight/system/work/FightWorkCompareDataAfterPlay.lua

module("modules.logic.fight.system.work.FightWorkCompareDataAfterPlay", package.seeall)

local FightWorkCompareDataAfterPlay = class("FightWorkCompareDataAfterPlay", BaseWork)

function FightWorkCompareDataAfterPlay:onStart(context)
	self._flow = FightWorkFlowSequence.New()

	self:_registCompareServer()
	self:_registRefreshPerformance()
	self._flow:registFinishCallback(self._onFlowFinish, self)
	self._flow:start()
end

function FightWorkCompareDataAfterPlay:_registCompareServer()
	self._flow:registWork(FightWorkCompareServerEntityData)
end

function FightWorkCompareDataAfterPlay:_registRefreshPerformance()
	self._flow:registWork(FightWorkRefreshPerformanceEntityData)
	self._flow:registWork(FightWorkFunction, self.refreshPerformanceData, self)
end

function FightWorkCompareDataAfterPlay:refreshPerformanceData()
	FightDataUtil.coverData(FightLocalDataMgr.instance.fieldMgr.param, FightDataMgr.instance.fieldMgr.param)
	FightDataUtil.coverData(FightLocalDataMgr.instance.fieldMgr.fightTaskBox, FightDataMgr.instance.fieldMgr.fightTaskBox)
	FightDataUtil.coverData(FightLocalDataMgr.instance.fieldMgr.progressDic, FightDataMgr.instance.fieldMgr.progressDic)
	FightDataUtil.coverData(FightLocalDataMgr.instance.fieldMgr.indicatorDict, FightDataMgr.instance.fieldMgr.indicatorDict)
end

function FightWorkCompareDataAfterPlay:_onFlowFinish()
	FightController.instance:dispatchEvent(FightEvent.AfterCorrectData)
	self:onDone(true)
end

function FightWorkCompareDataAfterPlay:clearWork()
	if self._flow then
		self._flow:disposeSelf()

		self._flow = nil
	end
end

return FightWorkCompareDataAfterPlay
