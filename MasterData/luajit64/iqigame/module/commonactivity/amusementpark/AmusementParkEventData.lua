-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkEventData.lua

local m = {
	monsters = {}
}
local AmusementParkMonsterData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkMonsterData")

function m.New(cid, type)
	local o = Clone(m)

	o:Init(cid, type)

	return o
end

function m:Init(cid, type)
	self.cid = cid
	self.type = type

	if self.type == AmusementParkConstant.EventType.Event_Fight then
		self.monsters = self:GetMonsters()
	end
end

function m:GetMonsters()
	local groupID = self:GetCfgData().Parameter
	local tab = {}

	for i, v in pairsCfg(CfgAmusementParkMonsterListTable) do
		if v.GroupNum == groupID then
			local pass = AmusementParkModule.ChallengeBossIsPass(groupID, v.Id)
			local data = AmusementParkMonsterData.New(v.Id, pass)

			table.insert(tab, data)
		end
	end

	table.sort(tab, function(a, b)
		return a:GetCfgData().BossLevel < b:GetCfgData().BossLevel
	end)

	return tab
end

function m:IsUnlock()
	local conditions = {}

	if self:GetCfgData().UnlockCondition > 0 then
		table.insert(conditions, self:GetCfgData().UnlockCondition)
	end

	local result = AmusementParkModule.CheckConditions(conditions)
	local needBuild = true

	if #self:GetCfgData().BattleBuildingLevel > 0 then
		local buildID = self:GetCfgData().BattleBuildingLevel[1]
		local buildData = AmusementParkModule.GetAmusementParkBuildData(buildID)
		local needLv = self:GetCfgData().BattleBuildingLevel[2]

		needBuild = needBuild and needLv <= buildData.parkBuildPOD.level
	end

	return result and needBuild
end

function m:KillProgress()
	local index = 1

	for i, v in pairs(self.monsters) do
		if not v.isPass then
			return false, index
		end

		index = index + 1
	end

	return true, index
end

function m:GetCfgData()
	return CfgAmusementParkEventControlTable[self.cid]
end

return m
