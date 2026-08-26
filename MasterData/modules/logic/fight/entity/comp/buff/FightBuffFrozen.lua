-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffFrozen.lua

module("modules.logic.fight.entity.comp.buff.FightBuffFrozen", package.seeall)

local FightBuffFrozen = class("FightBuffFrozen")
local Duration = 0.5
local BuffMatParam = {
	buff_stone = {
		"_TempOffset3",
		"Vector4",
		"1,0,0,0",
		"-2,0,0,0"
	},
	buff_ice = {
		"_TempOffsetTwoPass",
		"Vector4",
		"1,1,1,0.7",
		"-2,1,1,0.7"
	}
}

function FightBuffFrozen:onBuffStart(entity, buffMO)
	self.entity = entity
	self.buffMO = buffMO

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffFrozen:onBuffEnd()
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffFrozen:reset()
	self._preMatName = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
	TaskDispatcher.cancelTask(self._delayEnd, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FightBuffFrozen:dispose()
	TaskDispatcher.cancelTask(self._delayEnd, self)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, self._onChangeMaterial, self)
end

function FightBuffFrozen:_onChangeMaterial(entityId, spineMat)
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

	local propNamePow = "_Pow"
	local propNameFloorAlpha = "_FloorAlpha"
	local propTypePow = "Color"
	local propTypeFloorAlpha = "Vector4"

	if self.entity.spineRenderer then
		local spineOriginMat = self.entity.spineRenderer:getCloneOriginMat()
		local spineOriginPowValue = spineOriginMat and MaterialUtil.getPropValueFromMat(spineOriginMat, propNamePow, propTypePow)
		local spineOriginFloorAlphaValue = spineOriginMat and MaterialUtil.getPropValueFromMat(spineOriginMat, propNameFloorAlpha, propTypeFloorAlpha)

		if spineOriginPowValue then
			MaterialUtil.setPropValue(spineMat, propNamePow, propTypePow, spineOriginPowValue)
		end

		if spineOriginFloorAlphaValue then
			MaterialUtil.setPropValue(spineMat, propNameFloorAlpha, propTypeFloorAlpha, spineOriginFloorAlphaValue)
		end

		local propName = matParam[1]
		local propType = matParam[2]
		local startValue = MaterialUtil.getPropValueFromStr(propType, matParam[3])
		local endValue = MaterialUtil.getPropValueFromStr(propType, matParam[4])

		MaterialUtil.setPropValue(spineMat, propName, propType, startValue)

		local frameValue
		local propertyId = UnityEngine.Shader.PropertyToID(propName)

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, Duration, function(value)
			frameValue = MaterialUtil.getLerpValue(propType, startValue, endValue, value, frameValue)

			MaterialUtil.setPropValue(spineMat, propertyId, propType, frameValue)
		end)

		TaskDispatcher.runDelay(self._delayEnd, self, Duration)
	end
end

function FightBuffFrozen:_delayEnd()
	self._tweenId = nil
end

return FightBuffFrozen
