-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffImmuneControl.lua

module("modules.logic.fight.entity.comp.buff.FightBuffImmuneControl", package.seeall)

local FightBuffImmuneControl = class("FightBuffImmuneControl")
local BuffMatParam = {
	buff_immune = {
		"_TempOffsetTwoPass",
		"Vector4",
		"-0.2,4.2,-0.4,-0.2",
		"_OutlineColor",
		"Color",
		"12,9.55,5.83,1",
		"_NoiseMap4_ST",
		"Vector4",
		"0.1,0.1,0,0"
	}
}
local SpecialSkinParam = {
	["304901_kachakacha"] = {
		"_AlphaRange",
		"Vector4",
		"0,1,0,-1.78"
	},
	["304902_kachakacha"] = {
		"_AlphaRange",
		"Vector4",
		"0,1,0,-1.78"
	}
}

function FightBuffImmuneControl:onBuffStart(entity, buffMO)
	self.entity = entity
	self.buffMO = buffMO

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffImmuneControl:onBuffEnd()
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffImmuneControl:reset()
	self._preMatName = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffImmuneControl:dispose()
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffImmuneControl:_onChangeMaterial(entityId, spineMat)
	if entityId ~= self.entity.id then
		return
	end

	if self._preMatName and self._preMatName == spineMat.name then
		return
	end

	self._preMatName = spineMat.name

	local buffCO = lua_skill_buff.configDict[self.buffMO.buffId]
	local matParam = BuffMatParam[buffCO.mat]

	if not matParam then
		return
	end

	for i = 1, 9, 3 do
		local propName = matParam[i]
		local propType = matParam[i + 1]
		local value = matParam[i + 2]

		MaterialUtil.setPropValue(spineMat, propName, propType, MaterialUtil.getPropValueFromStr(propType, value))
	end

	local entityMO = self.entity:getMO()
	local skinCO = entityMO and entityMO:getSpineSkinCO()
	local skinSpine = skinCO and skinCO.spine
	local specialSkinParam = not string.nilorempty(skinSpine) and SpecialSkinParam[skinSpine]

	if specialSkinParam then
		for i = 1, 9, 3 do
			local propName = specialSkinParam[i]
			local propType = specialSkinParam[i + 1]
			local value = specialSkinParam[i + 2]

			MaterialUtil.setPropValue(spineMat, propName, propType, MaterialUtil.getPropValueFromStr(propType, value))
		end
	end
end

return FightBuffImmuneControl
