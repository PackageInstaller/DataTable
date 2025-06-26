-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGMapAreaData.lua

local m = {
	activatedElements = {}
}
local HorizontalRPGElementData = require("IQIGame.Module.CommonActivity.HorizontalRPG.HorizontalRPGElementData")

function m.New(cid, mapID, pos)
	local o = Clone(m)

	o:Init(cid, mapID, pos)

	return o
end

function m:Init(areaID, mapID, pos)
	self.cid = areaID
	self.mapID = mapID
	self.pos = pos
	self.activatedElements = {}

	for i = 1, #self:GetCfgData().EventList do
		local id = self:GetCfgData().EventList[i]
		local elementData = HorizontalRPGElementData.New(id, mapID, areaID)
		local isShow, rpgElementPOD = HorizontalRPGModule.IsShowElement(elementData.cid)

		elementData:UpDateState(isShow, rpgElementPOD)
		table.insert(self.activatedElements, elementData)
	end
end

function m:GetCfgData()
	return CfgHorizontalRPGAreaTable[self.cid]
end

function m:RefreshAreaData()
	for i, v in pairs(self.activatedElements) do
		local isShow, rpgElementPOD = HorizontalRPGModule.IsShowElement(v.cid)

		v:UpDateState(isShow, rpgElementPOD)
	end
end

function m:GetElementDataByID(cid)
	for i, v in pairs(self.activatedElements) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function m:GetElementDataByPos(pos)
	for i, v in pairs(self.activatedElements) do
		if v:GetCfgData().FirstPosition == pos and v.isShow then
			return v
		end
	end

	return nil
end

return m
