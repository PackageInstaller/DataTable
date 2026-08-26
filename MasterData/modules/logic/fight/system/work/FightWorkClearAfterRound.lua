-- chunkname: @modules/logic/fight/system/work/FightWorkClearAfterRound.lua

module("modules.logic.fight.system.work.FightWorkClearAfterRound", package.seeall)

local FightWorkClearAfterRound = class("FightWorkClearAfterRound", BaseWork)

function FightWorkClearAfterRound:onStart(context)
	FightRoundSequence.roundTempData = {}

	FightPlayCardModel.instance:clearUsedCards()
	self:onDone(true)
end

function FightWorkClearAfterRound:clearWork()
	return
end

return FightWorkClearAfterRound
