-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkOneConnectGame\\AmusementParkOneConnectLevelData.lua

local m = {
	LevelBlocks = {}
}

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid

	self:RestLevelBlock()
end

function m:RestLevelBlock()
	self.LevelBlocks = {}
end

function m:Create(blockData)
	table.insert(self.LevelBlocks, blockData)
end

function m:GetCfgData()
	return CfgAmusementParkOneTouchDrawingControlTable[self.cid]
end

function m:IsPass()
	local isUnlock = self:IsUnlock()
	local result = self:GetCfgData().Level <= AmusementParkOneConnectGameModule.maxLevel

	return isUnlock and result
end

function m:IsUnlock()
	for i = 1, #self:GetCfgData().UnlockBuildingLevel, 2 do
		local needBuildID = self:GetCfgData().UnlockBuildingLevel[i]
		local needLv = self:GetCfgData().UnlockBuildingLevel[i + 1]
		local buildData = AmusementParkModule.GetAmusementParkBuildData(needBuildID)

		if buildData == nil then
			return false
		end

		if needLv > buildData.parkBuildPOD.level then
			return false
		end
	end

	return true
end

return m
