-- chunkname: @modules/logic/fight/system/work/FightWorkCardsPush.lua

module("modules.logic.fight.system.work.FightWorkCardsPush", package.seeall)

local FightWorkCardsPush = class("FightWorkCardsPush", FightEffectBase)

function FightWorkCardsPush:onStart()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkCardsPush:_delayDone()
	self:onDone(true)
end

function FightWorkCardsPush:clearWork()
	return
end

return FightWorkCardsPush
