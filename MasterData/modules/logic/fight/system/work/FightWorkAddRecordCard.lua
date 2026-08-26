-- chunkname: @modules/logic/fight/system/work/FightWorkAddRecordCard.lua

module("modules.logic.fight.system.work.FightWorkAddRecordCard", package.seeall)

local FightWorkAddRecordCard = class("FightWorkAddRecordCard", FightEffectBase)

function FightWorkAddRecordCard:onStart()
	FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardData, self.actEffectData.buff)
	self:onDone(true)
end

return FightWorkAddRecordCard
