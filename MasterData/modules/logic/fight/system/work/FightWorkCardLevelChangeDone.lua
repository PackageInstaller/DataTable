-- chunkname: @modules/logic/fight/system/work/FightWorkCardLevelChangeDone.lua

module("modules.logic.fight.system.work.FightWorkCardLevelChangeDone", package.seeall)

local FightWorkCardLevelChangeDone = class("FightWorkCardLevelChangeDone", BaseWork)

function FightWorkCardLevelChangeDone:onStart()
	self:onDone(true)
end

return FightWorkCardLevelChangeDone
