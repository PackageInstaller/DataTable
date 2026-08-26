-- chunkname: @modules/logic/fight/system/work/FightWorkBufferFlyAddHandCard371.lua

module("modules.logic.fight.system.work.FightWorkBufferFlyAddHandCard371", package.seeall)

local FightWorkBufferFlyAddHandCard371 = class("FightWorkBufferFlyAddHandCard371", FightEffectBase)

function FightWorkBufferFlyAddHandCard371:onStart()
	return self:onDone(true)
end

return FightWorkBufferFlyAddHandCard371
