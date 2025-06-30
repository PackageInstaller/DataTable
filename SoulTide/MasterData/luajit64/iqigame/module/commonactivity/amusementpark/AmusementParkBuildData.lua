-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkBuildData.lua

local m = {}
local AmusementParkBuildPosData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkBuildPosData")

function m.New(cid, parkLandPOD)
	local o = Clone(m)

	o:Init(cid, parkLandPOD)

	return o
end

function m:Init(cid, parkLandPOD)
	self.cid = cid
	self.parkBuildPOD = parkLandPOD
	self.maxLevel = self:GetMaxLevel()
end

function m:GetCfgData()
	return CfgAmusementParkBuildingTable[self.cid]
end

function m:IsUnlock()
	if self.parkBuildPOD.post > 0 then
		return true
	end

	return false
end

function m:GetBuildFunctionData()
	if #self:GetCfgData().FunctionGroup > 0 then
		local funID = self:GetCfgData().FunctionGroup[1]

		return CfgAmusementParkFunctionControlTable[funID]
	end

	return nil
end

function m:GetMaxLevel()
	local maxLevel = 0

	for i, v in pairsCfg(CfgAmusementParkBuildingLevelTable) do
		if v.Group == AmusementParkModule.GlobalCid and v.BuildId == self.cid and maxLevel < v.Level then
			maxLevel = v.Level
		end
	end

	return maxLevel
end

function m:IsMaxLevel()
	return self.parkBuildPOD.level >= self.maxLevel
end

function m:GetCfgBuildLevelData()
	if self.parkBuildPOD then
		for i, v in pairsCfg(CfgAmusementParkBuildingLevelTable) do
			if v.BuildId == self.parkBuildPOD.unitID and v.Level == self.parkBuildPOD.level then
				return v
			end
		end
	end

	return nil
end

function m:GetBuildPlayerAttrs()
	local attr = {}
	local pos, count = self:GetBuildPostData()

	for i, v in pairs(pos) do
		if v.playerData and v.playerData.parkRolePOD then
			for key, value in pairs(v.playerData.parkRolePOD.attr) do
				local oldValue = attr[key] or 0

				attr[key] = oldValue + value
			end
		end
	end

	return attr
end

function m:GetBuildPlayers()
	local tab = {}
	local pos, count = self:GetBuildPostData()

	for i, v in pairs(pos) do
		if v.playerData then
			table.insert(tab, v.playerData.cid)
		end
	end

	return tab
end

function m:GetBuildPostData()
	local pos = {}
	local openCount = 0

	for i = 1, #self:GetCfgData().UnlockPostNeedLv do
		local unlockLv = self:GetCfgData().UnlockPostNeedLv[i]
		local unLock = unlockLv <= self.parkBuildPOD.level
		local soulID = self.parkBuildPOD.doll[i]
		local playerData

		if soulID ~= nil then
			playerData = AmusementParkModule.GetParkPlayerData(soulID)
		end

		local posData = AmusementParkBuildPosData.New(i, unLock, unlockLv, playerData)

		if unLock then
			openCount = openCount + 1
		end

		table.insert(pos, posData)
	end

	return pos, openCount
end

function m:IsCanLevelUp()
	local isMax = self:IsMaxLevel()

	if isMax then
		return false
	end

	local cfgBuildLevelData = self:GetCfgBuildLevelData()

	if cfgBuildLevelData == nil then
		return false
	end

	local conditionID = cfgBuildLevelData.LevelUpCondition
	local success = ConditionModule.Check(conditionID)

	if not success then
		return false
	end

	for i = 1, #cfgBuildLevelData.LevelUpNeedAtt, 2 do
		local attrType = cfgBuildLevelData.LevelUpNeedAtt[i]
		local needAttrNum = cfgBuildLevelData.LevelUpNeedAtt[i + 1]
		local success, attrNum = AmusementParkModule.CheckParkAttr(attrType, needAttrNum)

		if not success then
			return false
		end
	end

	for i = 1, #cfgBuildLevelData.LevelUpCost, 2 do
		local itemID = cfgBuildLevelData.LevelUpCost[i]
		local needNum = cfgBuildLevelData.LevelUpCost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)

		if haveNum < needNum then
			return false
		end
	end

	return true
end

return m
