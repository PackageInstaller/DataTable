-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/damage/EliminateTreatmentComp.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.damage.EliminateTreatmentComp", package.seeall)

local EliminateTreatmentComp = class("EliminateTreatmentComp", HpCompBase)

function EliminateTreatmentComp:ctor()
	self._baseTreatment = 0
	self._exTreatment = 0
	self._treatmentRate = 0
	self._eliminateTypeExTreatment = {}
end

function EliminateTreatmentComp:reset()
	self._baseTreatment = 0
	self._exTreatment = 0
	self._treatmentRate = 0
	self._eliminateTypeExTreatment = {}
end

function EliminateTreatmentComp:setExTreatment(treatment)
	self._exTreatment = treatment
end

function EliminateTreatmentComp:setEliminateTypeExTreatment(type, addTreatment)
	self._eliminateTypeExTreatment[type] = addTreatment
end

function EliminateTreatmentComp:setTreatmentRate(rate)
	self._treatmentRate = rate / 1000
end

local debugTempStr = "\n"

function EliminateTreatmentComp:treatment(eliminateRecordData)
	local totalTreatment = 0
	local eliminateTypeMap = eliminateRecordData:getEliminateTypeMap()

	for eliminateId, dataMap in pairs(eliminateTypeMap) do
		for _, data in pairs(dataMap) do
			if not string.nilorempty(eliminateId) and eliminateId ~= EliminateEnum_2_7.ChessType.stone then
				local eliminateType = data.eliminateType
				local eliminateCount = data.eliminateCount
				local spEliminateCount = data.spEliminateCount
				local baseTreatment, baseExTreatment = LengZhou6Config.instance:getHealValue(eliminateId, eliminateType)

				if baseExTreatment ~= nil and (eliminateType == EliminateEnum_2_7.eliminateType.cross or eliminateType == EliminateEnum_2_7.eliminateType.five) then
					baseExTreatment = (eliminateCount - 5) * baseExTreatment
				end

				if eliminateType == EliminateEnum_2_7.eliminateType.base then
					baseTreatment = baseTreatment * eliminateCount
				end

				if spEliminateCount ~= 0 and self._eliminateTypeExTreatment[eliminateId] ~= nil then
					baseExTreatment = baseExTreatment + self._eliminateTypeExTreatment[eliminateId] * spEliminateCount
				end

				if isDebugBuild then
					debugTempStr = debugTempStr .. "eliminateId = " .. eliminateId .. " eliminateType = " .. eliminateType .. " eliminateCount = " .. eliminateCount .. " spEliminateCount = " .. spEliminateCount .. " baseTreatment = " .. baseTreatment .. " baseExTreatment = " .. baseExTreatment .. "\n"
				end

				totalTreatment = totalTreatment + (baseTreatment + self._exTreatment + baseExTreatment) * (1 + self._treatmentRate)
			end
		end
	end

	if isDebugBuild then
		logNormal("消除治疗计算详情 = " .. debugTempStr)

		debugTempStr = "\n"

		logNormal("消除单次治疗 = ：" .. totalTreatment)
	end

	return totalTreatment
end

return EliminateTreatmentComp
