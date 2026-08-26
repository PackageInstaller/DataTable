-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkCreateEmitterEntity.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkCreateEmitterEntity", package.seeall)

local FightWorkCreateEmitterEntity = class("FightWorkCreateEmitterEntity", FightEffectBase)

function FightWorkCreateEmitterEntity:onStart()
	local sceneMgr = FightGameMgr.entityMgr

	if not sceneMgr then
		return self:onDone(true)
	end

	sceneMgr:addASFDUnit()
	self:onDone(true)
end

return FightWorkCreateEmitterEntity
