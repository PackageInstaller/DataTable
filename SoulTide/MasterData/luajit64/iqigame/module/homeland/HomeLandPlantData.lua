-- chunkname: @IQIGame\\Module\\HomeLand\\HomeLandPlantData.lua

HomeLandPlantData = {}

function HomeLandPlantData.New()
	local o = Clone(HomeLandPlantData)

	return o
end

function HomeLandPlantData:Init(buildingID, landPOD)
	self.buildingID = buildingID
	self.plantCid = landPOD.cid
	self.cfgPlantGridInfo = CfgHomeLandPlantGridTable[self.plantCid]
	self.decorateCid = self.cfgPlantGridInfo.Decorate
	self.landPOD = landPOD
end

return HomeLandPlantData
