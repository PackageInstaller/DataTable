-- chunkname: @IQIGame\\UI\\Battle\\BattleRoundController.lua

local m = {}
local RollingNumber = require("IQIGame.UI.Common.RollingNumber")

function m.New(curNumGrid, totalNumGrid)
	local obj = Clone(m)

	obj:Init(curNumGrid, totalNumGrid)

	return obj
end

function m:Init(curNumGrid, totalNumGO)
	self.CurNumGrid = curNumGrid
	self.StaticImageNumber = totalNumGO:GetComponent("Text")

	local numImages = {}

	for i = 1, 2 do
		numImages[i] = self.CurNumGrid.transform:Find("Num_" .. i).gameObject
	end

	self.RollingNumber = RollingNumber.New(numImages)
end

function m:SetRound(currentValue, maxValue)
	self.RollingNumber:RollTo(currentValue)

	self.StaticImageNumber.text = tostring(maxValue)
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.RollingNumber:Update(elapseSeconds, realElapseSeconds)
end

function m:Dispose()
	self.RollingNumber:Dispose()

	self.CurNumGrid = nil
	self.StaticImageNumber = nil
end

return m
