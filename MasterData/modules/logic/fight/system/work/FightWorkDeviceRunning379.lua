-- chunkname: @modules/logic/fight/system/work/FightWorkDeviceRunning379.lua

module("modules.logic.fight.system.work.FightWorkDeviceRunning379", package.seeall)

local FightWorkDeviceRunning379 = class("FightWorkDeviceRunning379", FightEffectBase)

function FightWorkDeviceRunning379:onStart()
	local success = self.actEffectData.effectNum == 1
	local deviceCardIndex = self.fightStepData.cardIndex
	local innerIndex = self.fightStepData:getDeviceInnerIndex()

	FightController.instance:dispatchEvent(FightEvent.OnDevice_ScanSkill, success, deviceCardIndex, innerIndex)
	self:onDone(true)
end

return FightWorkDeviceRunning379
