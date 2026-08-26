-- chunkname: @modules/logic/fight/system/work/FightWorkRandomDiceUseSkill353.lua

module("modules.logic.fight.system.work.FightWorkRandomDiceUseSkill353", package.seeall)

local FightWorkRandomDiceUseSkill353 = class("FightWorkRandomDiceUseSkill353", FightWorkEffectDice)

function FightWorkRandomDiceUseSkill353:onConstructor()
	FightDataHelper.tempMgr.douQuQuDice = true
end

function FightWorkRandomDiceUseSkill353:onDestructor()
	return
end

return FightWorkRandomDiceUseSkill353
