-- chunkname: @modules/logic/fight/system/work/FightEndRequestWork.lua

module("modules.logic.fight.system.work.FightEndRequestWork", package.seeall)

local FightEndRequestWork = class("FightEndRequestWork", BaseWork)

function FightEndRequestWork:onStart()
	FightController.instance:registerCallback(FightEvent.RespEndFight, self.onEndFight, self)
	FightController.instance:registerCallback(FightEvent.RespEndFight, self.onEndFight, self)
	FightRpc.instance:sendEndFightRequest(false)
end

function FightEndRequestWork:onEndFight(resultCode)
	FightController.instance:unregisterCallback(FightEvent.RespEndFight, self.onEndFight, self)
	FightController.instance:unregisterCallback(FightEvent.RespEndFight, self.onEndFight, self)
	self:onDone(true)
end

function FightEndRequestWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespEndFight, self.onEndFight, self)
	FightController.instance:unregisterCallback(FightEvent.RespEndFight, self.onEndFight, self)
end

return FightEndRequestWork
