-- chunkname: @modules/logic/fight/system/work/FightWorkLayerHaloSync.lua

module("modules.logic.fight.system.work.FightWorkLayerHaloSync", package.seeall)

local FightWorkLayerHaloSync = class("FightWorkLayerHaloSync", FightEffectBase)

function FightWorkLayerHaloSync:onStart()
	self:onDone(true)
end

function FightWorkLayerHaloSync:clearWork()
	return
end

return FightWorkLayerHaloSync
