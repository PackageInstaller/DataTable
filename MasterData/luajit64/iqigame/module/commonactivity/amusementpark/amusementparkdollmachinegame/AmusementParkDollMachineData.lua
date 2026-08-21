-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineData.lua

local m = {
	totalCount = 0,
	currentIndex = 0,
	currentScore = 0,
	totalScore = 0,
	gameRoles = {},
	totalRoles = {},
	currentRoles = {}
}
local AmusementParkDollMachineRoleData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkDollMachineGame.AmusementParkDollMachineRoleData")

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cid = cid
	self.totalScore = 0
	self.totalCount = self:GetCfgData().ChallengeCount
	self.totalRoles = {}
	self.currentIndex = 0
	self.currentScore = 0
	self.currentRoles = {}
	self.gameRoles = self:CreateRoles()
end

function m:GetCfgData()
	return CfgAmusementParkDollMachineControlTable[self.cid]
end

function m:CreateRoles()
	local roles = {}
	local totalGroupRoles = {}

	for i, v in pairsCfg(CfgAmusementParkDollMachineRoleTable) do
		if v.Group == AmusementParkModule.GlobalCid then
			table.insert(totalGroupRoles, v.Id)
		end
	end

	self:RandomData(totalGroupRoles)

	local index = 1

	for i = 1, #self:GetCfgData().RoleRareNum do
		local rare = i
		local rareNum = self:GetCfgData().RoleRareNum[i]
		local rareSpeed = self:GetCfgData().RoleRareSpeed[i]
		local rareScore = self:GetCfgData().RoleRareScore[i]

		for j = 1, rareNum do
			local roleCid = totalGroupRoles[index]
			local gameRoleData = AmusementParkDollMachineRoleData.New(roleCid, rare, rareSpeed, rareScore)

			table.insert(roles, gameRoleData)

			index = index + 1
		end
	end

	return roles
end

function m:RandomData(roles)
	for i = #roles, 2, -1 do
		local random_index = math.random(i)

		roles[i], roles[random_index] = roles[random_index], roles[i]
	end
end

function m:StartCatchRoles()
	if self.currentIndex >= self.totalCount then
		return
	end

	self.currentScore = 0
	self.currentRoles = {}
end

function m:EndCatchRoles(roles)
	self.currentIndex = self.currentIndex + 1

	local addScore = 0

	for i, v in pairs(roles) do
		table.insert(self.currentRoles, v)
		table.insert(self.totalRoles, v)

		for k, roleData in pairs(self.gameRoles) do
			if v.cid == roleData.cid then
				self.gameRoles[k] = nil
			end
		end

		addScore = addScore + self:GetCfgData().RoleRareScore[v.roleRare]
	end

	if #roles > 1 then
		addScore = addScore * (1 + self:GetCfgData().ExtraScore / 100 * (#roles - 1))
	end

	self.currentScore = self.currentScore + addScore
	self.totalScore = self.totalScore + addScore
end

function m:IsGameEnd()
	return self.currentIndex >= self.totalCount
end

return m
