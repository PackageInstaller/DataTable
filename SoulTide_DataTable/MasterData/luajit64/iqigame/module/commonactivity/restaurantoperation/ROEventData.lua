-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROEventData.lua

local m = {
	monsters = {}
}
local RestaurantOperationMonsterData = require("IQIGame.Module.CommonActivity.RestaurantOperation.RestaurantOperationMonsterData")

function m.New(cid, type)
	local o = Clone(m)

	o:Init(cid, type)

	return o
end

function m:Init(cid, type)
	self.cid = cid
	self.type = type

	if self.type == RestaurantOperationConstant.EventType.Event_Fight then
		self.monsters = self:GetMonsters()
	end
end

function m:GetMonsters()
	local groupID = self:GetCfgData().Parameter
	local tab = {}

	for i, v in pairsCfg(CfgRestaurantOperationMonsterListTable) do
		if v.GroupNum == groupID then
			local pass = RestaurantOperationModule.ChallengeBossIsPass(groupID, v.Id)
			local data = RestaurantOperationMonsterData.New(v.Id, pass)

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

	local result = RestaurantOperationModule.CheckConditions(conditions)

	return result
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
	return CfgRestaurantOperationEventControlTable[self.cid]
end

return m
