-- chunkname: @modules/logic/fight/system/work/FightWorkRouge2MusicBallChange361.lua

module("modules.logic.fight.system.work.FightWorkRouge2MusicBallChange361", package.seeall)

local FightWorkRouge2MusicBallChange361 = class("FightWorkRouge2MusicBallChange361", FightEffectBase)

function FightWorkRouge2MusicBallChange361:onStart()
	self:com_sendFightEvent(FightEvent.Rouge2_ForceRefreshMusicType)

	return self:onDone(true)
end

return FightWorkRouge2MusicBallChange361
