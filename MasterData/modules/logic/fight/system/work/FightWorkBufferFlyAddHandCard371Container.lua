-- chunkname: @modules/logic/fight/system/work/FightWorkBufferFlyAddHandCard371Container.lua

module("modules.logic.fight.system.work.FightWorkBufferFlyAddHandCard371Container", package.seeall)

local FightWorkBufferFlyAddHandCard371Container = class("FightWorkBufferFlyAddHandCard371Container", FightStepEffectFlow)

FightWorkBufferFlyAddHandCard371Container.EventDuration = 2.2

function FightWorkBufferFlyAddHandCard371Container:onStart()
	local effectList = FightHelper.getActEffectDataList(FightEnum.EffectType.BUFFERFLYADDHANDCARD, self.fightStepData, {})

	if not effectList then
		return self:onDone(true)
	end

	for i = #effectList, 1, -1 do
		local actEffect = effectList[i]

		if actEffect:isDone() then
			table.remove(effectList, i)
		else
			FightDataHelper.playEffectData(actEffect)
		end
	end

	if #effectList < 1 then
		return self:onDone(true)
	end

	self:cancelFightWorkSafeTimer()
	ViewMgr.instance:openView(ViewName.FightLorentzCardCopyView, effectList)
	TaskDispatcher.runDelay(self.onEventDone, self, FightWorkBufferFlyAddHandCard371Container.EventDuration)
end

function FightWorkBufferFlyAddHandCard371Container:onEventDone()
	ViewMgr.instance:closeView(ViewName.FightLorentzCardCopyView, true)
	self:onDone(true)
end

function FightWorkBufferFlyAddHandCard371Container:clearWork()
	ViewMgr.instance:closeView(ViewName.FightLorentzCardCopyView, true)
	TaskDispatcher.cancelTask(self.onEventDone, self)
end

return FightWorkBufferFlyAddHandCard371Container
