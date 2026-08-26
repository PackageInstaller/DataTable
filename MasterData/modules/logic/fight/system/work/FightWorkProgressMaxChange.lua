-- chunkname: @modules/logic/fight/system/work/FightWorkProgressMaxChange.lua

module("modules.logic.fight.system.work.FightWorkProgressMaxChange", package.seeall)

local FightWorkProgressMaxChange = class("FightWorkProgressMaxChange", FightEffectBase)

function FightWorkProgressMaxChange:onStart()
	self:com_sendMsg(FightMsgId.FightMaxProgressValueChange, self.actEffectData.buffActId)
	self:onDone(true)
end

function FightWorkProgressMaxChange:clearWork()
	return
end

return FightWorkProgressMaxChange
