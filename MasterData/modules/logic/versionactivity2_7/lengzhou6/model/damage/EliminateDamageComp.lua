-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/damage/EliminateDamageComp.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.damage.EliminateDamageComp", package.seeall)

local EliminateDamageComp = class("EliminateDamageComp", HpCompBase)

function EliminateDamageComp:ctor()
	self._baseDamage = 0
	self._exDamage = 0
	self._damageRate = 0
	self._normalEliminateDamageRate = 0
	self._FourEliminateDamageRate = 0
	self._FiveEliminateDamageRate = 0
	self._CrossEliminateDamageRate = 0
	self._eliminateTypeExDamage = {}
end

function EliminateDamageComp:reset()
	self._baseDamage = 0
	self._exDamage = 0
	self._damageRate = 0
	self._normalEliminateDamageRate = 0
	self._FourEliminateDamageRate = 0
	self._FiveEliminateDamageRate = 0
	self._CrossEliminateDamageRate = 0
	self._eliminateTypeExDamage = {}
end

function EliminateDamageComp:setSpEliminateRate(fourRate, crossRate, fiveRate)
	self._FourEliminateDamageRate = fourRate / 1000
	self._CrossEliminateDamageRate = crossRate / 1000
	self._FiveEliminateDamageRate = fiveRate / 1000
end

function EliminateDamageComp:setEliminateTypeExDamage(type, addDamage)
	self._eliminateTypeExDamage[type] = addDamage
end

function EliminateDamageComp:setExDamage(damage)
	self._exDamage = damage
end

function EliminateDamageComp:setDamageRate(rate)
	self._damageRate = rate / 1000
end

local debugTempStr = "\n"

function EliminateDamageComp:damage(eliminateRecordData)
	local totalDamage = 0
	local eliminateTypeMap = eliminateRecordData:getEliminateTypeMap()

	for eliminateId, dataMap in pairs(eliminateTypeMap) do
		local damageRate = 0

		for _, data in pairs(dataMap) do
			if not string.nilorempty(eliminateId) and eliminateId ~= EliminateEnum_2_7.ChessType.stone then
				local eliminateType = data.eliminateType
				local eliminateCount = data.eliminateCount
				local spEliminateCount = data.spEliminateCount
				local baseDamage, baseExDamage = LengZhou6Config.instance:getDamageValue(eliminateId, eliminateType)
				local _exDamage = self._exDamage

				if baseExDamage ~= nil and (eliminateType == EliminateEnum_2_7.eliminateType.cross or eliminateType == EliminateEnum_2_7.eliminateType.five) then
					baseExDamage = (eliminateCount - 5) * baseExDamage
				end

				if eliminateType == EliminateEnum_2_7.eliminateType.four then
					damageRate = self._FourEliminateDamageRate
				end

				if eliminateType == EliminateEnum_2_7.eliminateType.five then
					damageRate = self._FiveEliminateDamageRate
				end

				if eliminateType == EliminateEnum_2_7.eliminateType.cross then
					damageRate = self._CrossEliminateDamageRate
				end

				if eliminateType == EliminateEnum_2_7.eliminateType.base then
					baseDamage = baseDamage * eliminateCount
					_exDamage = 0
				end

				if spEliminateCount ~= 0 and self._eliminateTypeExDamage[eliminateId] ~= nil then
					baseExDamage = baseExDamage + self._eliminateTypeExDamage[eliminateId] * spEliminateCount
				end

				if baseDamage ~= 0 then
					if isDebugBuild then
						debugTempStr = debugTempStr .. "eliminateId = " .. eliminateId .. " eliminateType = " .. eliminateType .. " eliminateCount = " .. eliminateCount .. " spEliminateCount = " .. spEliminateCount .. " baseDamage = " .. baseDamage .. " baseExDamage = " .. baseExDamage .. " exDamage = " .. _exDamage .. " damageRate = " .. damageRate .. "\n"
					end

					totalDamage = totalDamage + (baseDamage + baseExDamage + _exDamage) * (1 + damageRate)
				end
			end
		end
	end

	if isDebugBuild then
		logNormal("消除伤害详情 = " .. debugTempStr)

		debugTempStr = "\n"

		logNormal("消除单次伤害 = " .. totalDamage)
	end

	return totalDamage
end

return EliminateDamageComp
