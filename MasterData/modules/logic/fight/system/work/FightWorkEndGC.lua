-- chunkname: @modules/logic/fight/system/work/FightWorkEndGC.lua

module("modules.logic.fight.system.work.FightWorkEndGC", package.seeall)

local FightWorkEndGC = class("FightWorkEndGC", BaseWork)

function FightWorkEndGC:onStart()
	FightPreloadController.instance:releaseTimelineRefAsset()
	FightHelper.clearNoUseEffect()
	self:onDone(true)
end

return FightWorkEndGC
