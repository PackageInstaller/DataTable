-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffBeContractedBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffBeContractedBuff", package.seeall)

local FightBuffBeContractedBuff = class("FightBuffBeContractedBuff")

function FightBuffBeContractedBuff:ctor()
	return
end

function FightBuffBeContractedBuff:onBuffStart(entity, buffMO)
	FightModel.instance:setBeContractEntityUid(entity.id)
	FightController.instance:dispatchEvent(FightEvent.BeContract, entity.id)
end

function FightBuffBeContractedBuff:onBuffEnd()
	FightModel.instance:setBeContractEntityUid(nil)
end

return FightBuffBeContractedBuff
