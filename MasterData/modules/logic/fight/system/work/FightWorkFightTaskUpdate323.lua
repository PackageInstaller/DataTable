-- chunkname: @modules/logic/fight/system/work/FightWorkFightTaskUpdate323.lua

module("modules.logic.fight.system.work.FightWorkFightTaskUpdate323", package.seeall)

local FightWorkFightTaskUpdate323 = class("FightWorkFightTaskUpdate323", FightEffectBase)

function FightWorkFightTaskUpdate323:onStart()
	FightController.instance:dispatchEvent(FightEvent.TaskDataUpdate)
	self:onDone(true)
end

function FightWorkFightTaskUpdate323:clearWork()
	return
end

return FightWorkFightTaskUpdate323
