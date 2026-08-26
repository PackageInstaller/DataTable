-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffContractBuff.lua

module("modules.logic.fight.entity.comp.buff.FightBuffContractBuff", package.seeall)

local FightBuffContractBuff = class("FightBuffContractBuff")

function FightBuffContractBuff:ctor()
	return
end

function FightBuffContractBuff:onBuffStart(entity, buffMO)
	FightModel.instance:setContractEntityUid(entity.id)
end

function FightBuffContractBuff:onBuffEnd()
	FightModel.instance:setContractEntityUid(nil)
end

return FightBuffContractBuff
