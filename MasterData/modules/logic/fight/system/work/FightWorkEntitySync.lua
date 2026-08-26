-- chunkname: @modules/logic/fight/system/work/FightWorkEntitySync.lua

module("modules.logic.fight.system.work.FightWorkEntitySync", package.seeall)

local FightWorkEntitySync = class("FightWorkEntitySync", FightEffectBase)

function FightWorkEntitySync:onStart()
	local entity = self.actEffectData.entity

	if entity then
		self:com_sendFightEvent(FightEvent.EntitySync, entity.id)
	end

	self:onDone(true)
end

function FightWorkEntitySync:clearWork()
	return
end

return FightWorkEntitySync
