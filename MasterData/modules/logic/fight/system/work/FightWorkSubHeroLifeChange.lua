-- chunkname: @modules/logic/fight/system/work/FightWorkSubHeroLifeChange.lua

module("modules.logic.fight.system.work.FightWorkSubHeroLifeChange", package.seeall)

local FightWorkSubHeroLifeChange = class("FightWorkSubHeroLifeChange", FightEffectBase)

function FightWorkSubHeroLifeChange:onStart()
	self._entityId = self.actEffectData.targetId

	FightController.instance:dispatchEvent(FightEvent.ChangeSubEntityHp, self._entityId, self.actEffectData.effectNum)
	self:onDone(true)
end

function FightWorkSubHeroLifeChange:clearWork()
	return
end

return FightWorkSubHeroLifeChange
