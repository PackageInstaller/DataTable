-- chunkname: @modules/logic/fight/system/work/fightparamwork/FightParamWorkBase.lua

module("modules.logic.fight.system.work.fightparamwork.FightParamWorkBase", package.seeall)

local FightParamWorkBase = class("FightParamWorkBase", FightWorkItem)

function FightParamWorkBase:onLogicEnter(keyId, oldValue, currValue, offset)
	self.keyId = keyId
	self.oldValue = oldValue
	self.currValue = currValue
	self.offset = offset
end

function FightParamWorkBase:onStart()
	self:onDone(true)
end

return FightParamWorkBase
