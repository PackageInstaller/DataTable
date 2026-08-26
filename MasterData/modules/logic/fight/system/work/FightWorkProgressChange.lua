-- chunkname: @modules/logic/fight/system/work/FightWorkProgressChange.lua

module("modules.logic.fight.system.work.FightWorkProgressChange", package.seeall)

local FightWorkProgressChange = class("FightWorkProgressChange", FightEffectBase)

function FightWorkProgressChange:beforePlayEffectData()
	self._oldValue = FightDataHelper.fieldMgr.progress
end

function FightWorkProgressChange:onStart()
	self:com_sendMsg(FightMsgId.FightProgressValueChange)

	local pregressId = self.actEffectData.buffActId

	if pregressId == 0 then
		self._maxValue = FightDataHelper.fieldMgr.progressMax

		if self._oldValue < self._maxValue and FightDataHelper.fieldMgr.progress >= self._maxValue then
			self:com_registTimer(self._delayAfterPerformance, 0.25 / FightModel.instance:getUISpeed())
		else
			self:onDone(true)
		end
	else
		local work = FightMsgMgr.sendMsg(FightMsgId.NewProgressValueChange, pregressId)

		if work then
			self:playWorkAndDone(work)
		else
			self:onDone(true)
		end
	end
end

function FightWorkProgressChange:clearWork()
	return
end

return FightWorkProgressChange
