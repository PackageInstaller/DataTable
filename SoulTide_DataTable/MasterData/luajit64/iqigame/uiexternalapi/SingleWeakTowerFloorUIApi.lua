-- chunkname: @IQIGame\\UIExternalApi\\SingleWeakTowerFloorUIApi.lua

SingleWeakTowerFloorUIApi = BaseLangApi:Extend()

function SingleWeakTowerFloorUIApi:Init()
	self:RegisterApi("TowerTypeName", self.GetTowerTypeName)
	self:RegisterApi("ItemNumText", self.GetItemNumText)
end

function SingleWeakTowerFloorUIApi:GetItemNumText(num)
	return string.format(self:GetCfgText(9101506), num)
end

function SingleWeakTowerFloorUIApi:GetTowerTypeName(type)
	local typeName = ""

	if type == 1 then
		typeName = self:GetCfgText(9101501)
	elseif type == 2 then
		typeName = self:GetCfgText(9101502)
	elseif type == 3 then
		typeName = self:GetCfgText(9101503)
	elseif type == 4 then
		typeName = self:GetCfgText(9101504)
	elseif type == 5 then
		typeName = self:GetCfgText(9101505)
	end

	return typeName
end

SingleWeakTowerFloorUIApi:Init()
