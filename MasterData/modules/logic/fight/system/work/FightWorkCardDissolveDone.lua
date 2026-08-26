-- chunkname: @modules/logic/fight/system/work/FightWorkCardDissolveDone.lua

module("modules.logic.fight.system.work.FightWorkCardDissolveDone", package.seeall)

local FightWorkCardDissolveDone = class("FightWorkCardDissolveDone", BaseWork)

function FightWorkCardDissolveDone:onStart()
	self:onDone(true)
end

return FightWorkCardDissolveDone
