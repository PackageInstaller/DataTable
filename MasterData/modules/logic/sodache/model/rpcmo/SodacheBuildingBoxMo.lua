-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheBuildingBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheBuildingBoxMo", package.seeall)

local SodacheBuildingBoxMo = pureTable("SodacheBuildingBoxMo")

function SodacheBuildingBoxMo:init(data)
	self.buildings, self.buildingsMap = GameUtil.rpcInfosToListAndMap(data.buildings, SodacheBuildingMo, "type")
end

function SodacheBuildingBoxMo:getBuildingMo(type)
	return self.buildingsMap[type]
end

function SodacheBuildingBoxMo:getBuildingLv(buildingType)
	local mo = self:getBuildingMo(buildingType)

	if not mo then
		return 0
	end

	return mo.level
end

return SodacheBuildingBoxMo
