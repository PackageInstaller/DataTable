-- chunkname: @modules/logic/fight/system/work/FightWorkRouge2Check362.lua

module("modules.logic.fight.system.work.FightWorkRouge2Check362", package.seeall)

local FightWorkRouge2Check362 = class("FightWorkRouge2Check362", FightEffectBase)

FightWorkRouge2Check362.WaitTime = 3

function FightWorkRouge2Check362:onStart()
	logNormal("肉鸽2检定结果 : " .. tostring(self.actEffectData.reserveStr))
	self:onDone(true)
end

return FightWorkRouge2Check362
