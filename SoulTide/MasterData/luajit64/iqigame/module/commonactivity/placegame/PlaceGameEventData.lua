-- chunkname: @IQIGame\\Module\\CommonActivity\\PlaceGame\\PlaceGameEventData.lua

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
	return CfgPlaceGameEventTable[self.cid]
end

function m:GetEventState()
	local state = 4

	if self:IsUnlock() then
		state = self:IsComplete() and 3 or self:IsCompletePrePlot() and 1 or 2
	end

	return state
end

function m:IsUnlock()
	local passFloor = 0

	if PlaceGameModule.DailyDupPOD.placeGamePOD.customs > 0 then
		passFloor = CfgPlaceGameTowerTable[PlaceGameModule.DailyDupPOD.placeGamePOD.customs].Floor
	end

	if passFloor >= self:GetCfgData().UnlockTower then
		return true
	end

	return false
end

function m:IsCompletePrePlot()
	local prePlotID = self:GetCfgData().PreStory

	if prePlotID > 0 and table.indexOf(PlaceGameModule.DailyDupPOD.placeGamePOD.plot, prePlotID) == -1 then
		return false
	end

	return true
end

function m:IsComplete()
	if table.indexOf(PlaceGameModule.DailyDupPOD.placeGamePOD.plot, self.cid) ~= -1 then
		return true
	end

	return false
end

return m
