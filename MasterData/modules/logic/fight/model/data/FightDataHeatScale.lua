-- chunkname: @modules/logic/fight/model/data/FightDataHeatScale.lua

module("modules.logic.fight.model.data.FightDataHeatScale", package.seeall)

local FightDataHeatScale = FightDataClass("FightDataHeatScale")

function FightDataHeatScale:onConstructor(headScale)
	self.value = headScale and tonumber(headScale.value) or 0
	self.max = headScale and tonumber(headScale.max) or 0

	if headScale then
		self.crystal = headScale.crystal or 0
	end
end

function FightDataHeatScale:changeMaxValue(value)
	self.max = self.max + value
end

function FightDataHeatScale:changeValue(value)
	self.value = self.value + value
end

function FightDataHeatScale:setCrystal(value)
	self.crystal = value
end

function FightDataHeatScale:getCrystalNum()
	return FightHelper.getCrystalNum(self.crystal)
end

function FightDataHeatScale:getMaxCrystalNum()
	local totalSelect = FightHelper.getBLECrystalParam()

	return totalSelect or 0
end

function FightDataHeatScale:hasCrystal()
	return self.crystal > 0
end

return FightDataHeatScale
