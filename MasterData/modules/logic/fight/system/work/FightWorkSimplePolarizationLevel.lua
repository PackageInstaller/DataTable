-- chunkname: @modules/logic/fight/system/work/FightWorkSimplePolarizationLevel.lua

module("modules.logic.fight.system.work.FightWorkSimplePolarizationLevel", package.seeall)

local FightWorkSimplePolarizationLevel = class("FightWorkSimplePolarizationLevel", FightEffectBase)

function FightWorkSimplePolarizationLevel:onStart()
	self:com_sendMsg(FightMsgId.RefreshSimplePolarizationLevel)
	self:onDone(true)
end

return FightWorkSimplePolarizationLevel
