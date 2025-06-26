-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGMapData.lua

local m = {
	currentAreaPos = 1,
	mapAreas = {}
}
local HorizontalRPGMapAreaData = require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGMapAreaData")

function m.New(cid, currentAreaID)
	local o = Clone(m)

	o:Init(cid, currentAreaID)

	return o
end

function m:Init(cid, currentAreaID)
	self.cid = cid

	self:ChangeArea(currentAreaID)

	self.mapAreas = {}

	for i = 1, #self:GetCfgData().AreaList do
		local areaID = self:GetCfgData().AreaList[i]
		local areaData = HorizontalRPGMapAreaData.New(areaID, cid, i)

		self.mapAreas[i] = areaData
	end
end

function m:GetCfgData()
	return CfgHorizontalRPGMapTable[self.cid]
end

function m:GetMapBirthPath()
	local areaID = self:GetCfgData().BornArea
	local areaPos = table.indexOf(self:GetCfgData().AreaList, areaID)
	local elementPos = self:GetCfgData().BornPoint
	local elementID

	if HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD and HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs then
		elementID = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.horizontalRPGMapPODs.born
	end

	if elementID then
		local elementData = self:GetElementData(elementID)

		if elementData then
			areaID = elementData.areaID
			areaPos = table.indexOf(self:GetCfgData().AreaList, areaID)
			elementPos = elementData:GetCfgData().FirstPosition
		end
	end

	local path = "Root/AreaNode/pos" .. areaPos .. "/" .. areaID .. "/Root/ElementNode/" .. elementPos

	return path
end

function m:GetShowAreas()
	local showAreaPos = {}

	for i = 1, #self:GetCfgData().AreaList do
		if math.abs(self.currentAreaPos - i) <= 2 then
			table.insert(showAreaPos, i)
		end
	end

	return showAreaPos
end

function m:GetElementData(elementID)
	for i, v in pairs(self.mapAreas) do
		local element = v:GetElementDataByID(elementID)

		if element then
			return element
		end
	end

	return nil
end

function m:ChangeArea(areaID)
	self.currentAreaID = areaID
	self.currentAreaPos = table.indexOf(self:GetCfgData().AreaList, self.currentAreaID)

	self:RefreshMapData()
end

function m:RefreshMapData()
	for i, v in pairs(self.mapAreas) do
		v:RefreshAreaData()
	end
end

return m
