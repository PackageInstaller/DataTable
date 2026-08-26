-- chunkname: @modules/logic/fight/system/work/FightWorkFocusMonsterAfterChangeHero.lua

module("modules.logic.fight.system.work.FightWorkFocusMonsterAfterChangeHero", package.seeall)

local FightWorkFocusMonsterAfterChangeHero = class("FightWorkFocusMonsterAfterChangeHero", FightWorkItem)

function FightWorkFocusMonsterAfterChangeHero:onConstructor()
	self._counter = 0
end

function FightWorkFocusMonsterAfterChangeHero:onStart()
	self:cancelFightWorkSafeTimer()

	local entityId, config = FightWorkFocusMonster.getFocusEntityId()

	if entityId and self._counter < 5 then
		self._counter = self._counter + 1

		local flow = self:com_registFlowSequence()

		flow:addWork(Work2FightWork.New(FightWorkFocusMonster))
		flow:registFinishCallback(self.onStart, self)
		flow:start()
	else
		self:onDone(true)
	end
end

function FightWorkFocusMonsterAfterChangeHero:clearWork()
	return
end

return FightWorkFocusMonsterAfterChangeHero
