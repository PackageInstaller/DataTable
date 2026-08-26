-- chunkname: @modules/logic/fight/entity/comp/buffspecialprecessitem/FightBuffJuDaBenYePuDormancyHand.lua

module("modules.logic.fight.entity.comp.buffspecialprecessitem.FightBuffJuDaBenYePuDormancyHand", package.seeall)

local FightBuffJuDaBenYePuDormancyHand = class("FightBuffJuDaBenYePuDormancyHand", FightBuffJuDaBenYePuDormancyTail)

function FightBuffJuDaBenYePuDormancyHand:getPlayValue()
	local oldValue = MaterialUtil.getPropValueFromMat(self._entityMat, "_TempOffset3", "Vector4")
	local startValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,0,%f,0", oldValue.z))
	local endValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,1,%f,0", oldValue.z))

	return startValue, endValue
end

function FightBuffJuDaBenYePuDormancyHand:getCloseValue()
	local oldValue = MaterialUtil.getPropValueFromMat(self._entityMat, "_TempOffset3", "Vector4")
	local startValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,1,%f,0", oldValue.z))
	local endValue = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,0,%f,0", oldValue.z))

	return startValue, endValue
end

return FightBuffJuDaBenYePuDormancyHand
