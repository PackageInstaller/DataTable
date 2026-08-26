-- chunkname: @modules/logic/fight/entity/comp/FightAssembledMonsterSpineSub.lua

module("modules.logic.fight.entity.comp.FightAssembledMonsterSpineSub", package.seeall)

local FightAssembledMonsterSpineSub = class("FightAssembledMonsterSpineSub")

function FightAssembledMonsterSpineSub:play(...)
	self.unitSpawn.mainSpine:playBySub(self.unitSpawn, ...)
end

function FightAssembledMonsterSpineSub:ctor(unitSpawn)
	self.unitSpawn = unitSpawn
end

function FightAssembledMonsterSpineSub:registLoadSpineWork(customUrl)
	return FightMsgMgr.sendMsg(FightMsgId.GetEmptyWorkFromEntrustedWorkMgr)
end

function FightAssembledMonsterSpineSub.__index(t, key)
	if FightAssembledMonsterSpineSub[key] then
		return FightAssembledMonsterSpineSub[key]
	else
		return t.unitSpawn.mainSpine[key]
	end
end

return FightAssembledMonsterSpineSub
