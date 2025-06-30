-- chunkname: @IQIGame\\Module\\Mining\\MiningPlantData.lua

local m = {}

function m.New(layerID, gridPOD)
	local o = Clone(m)

	o:Init(layerID, gridPOD)

	return o
end

function m:Init(layerID, gridPOD)
	self.layerID = layerID
	self.miningGridPOD = gridPOD
end

function m:GetCfgElementData()
	return CfgMiningElementTable[self.miningGridPOD.dataCid]
end

function m:IsStairType()
	local type = self:GetCfgElementData().Type

	if type == Constant.MiningElementType.MiningElementType_Descending_Stairs or type == Constant.MiningElementType.MiningElementType_Climbing_Stairs then
		return true
	end

	return false
end

return m
