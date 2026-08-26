-- chunkname: @modules/logic/fight/system/work/FightEmptyWork.lua

module("modules.logic.fight.system.work.FightEmptyWork", package.seeall)

local FightEmptyWork = class("FightEmptyWork", FightWorkItem)

function FightEmptyWork:onConstructor()
	return
end

function FightEmptyWork:onStart()
	self:onDone(true)
end

return FightEmptyWork
