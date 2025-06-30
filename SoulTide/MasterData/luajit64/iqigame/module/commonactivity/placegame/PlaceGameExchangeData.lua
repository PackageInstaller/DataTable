-- chunkname: @IQIGame\\Module\\CommonActivity\\PlaceGame\\PlaceGameExchangeData.lua

local m = {}

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid
end

function m:GetCfgData()
	return CfgPlaceGameBoxExchangeTable[self.cid]
end

function m:IsOpen()
	local passFloor = 0

	if PlaceGameModule.DailyDupPOD.placeGamePOD.customs > 0 then
		passFloor = CfgPlaceGameTowerTable[PlaceGameModule.DailyDupPOD.placeGamePOD.customs].Floor
	end

	if passFloor >= self:GetCfgData().NeedTower then
		return true
	end

	return false
end

return m
