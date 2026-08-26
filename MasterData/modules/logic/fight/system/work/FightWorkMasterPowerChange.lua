-- chunkname: @modules/logic/fight/system/work/FightWorkMasterPowerChange.lua

module("modules.logic.fight.system.work.FightWorkMasterPowerChange", package.seeall)

local FightWorkMasterPowerChange = class("FightWorkMasterPowerChange", FightEffectBase)

function FightWorkMasterPowerChange:onStart()
	self:_delayDone()
end

function FightWorkMasterPowerChange:_delayDone()
	self:onDone(true)
end

function FightWorkMasterPowerChange:clearWork()
	return
end

return FightWorkMasterPowerChange
