-- chunkname: @modules/logic/fight/system/work/FightWorkRouge2MusicCardChange360.lua

module("modules.logic.fight.system.work.FightWorkRouge2MusicCardChange360", package.seeall)

local FightWorkRouge2MusicCardChange360 = class("FightWorkRouge2MusicCardChange360", FightEffectBase)

function FightWorkRouge2MusicCardChange360:onStart()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)

	return self:onDone(true)
end

return FightWorkRouge2MusicCardChange360
