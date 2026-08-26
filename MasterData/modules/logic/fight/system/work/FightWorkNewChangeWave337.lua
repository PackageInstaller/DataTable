-- chunkname: @modules/logic/fight/system/work/FightWorkNewChangeWave337.lua

module("modules.logic.fight.system.work.FightWorkNewChangeWave337", package.seeall)

local FightWorkNewChangeWave337 = class("FightWorkNewChangeWave337", FightEffectBase)

function FightWorkNewChangeWave337:onStart()
	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(Work2FightWork, FightWorkStepChangeWave, self.actEffectData.fight)
	flow:registWork(Work2FightWork, FightWorkAppearTimeline)
	flow:registWork(Work2FightWork, FightWorkStartBornEnemy)
	flow:registWork(Work2FightWork, FightWorkFocusMonster)
	flow:registWork(FightWorkFunction, self.sendChangeWaveEvent, self)
	flow:start({})
end

function FightWorkNewChangeWave337:sendChangeWaveEvent()
	FightController.instance:beginWave()
end

return FightWorkNewChangeWave337
