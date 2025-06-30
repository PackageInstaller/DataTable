-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkDollMachineGame\\AmusementParkDollMachineRoleData.lua

local m = {
	roleRare = 0,
	roleRareSpeed = 0,
	roleRareScore = 0,
	cid = 0
}

function m.New(cid, roleRare, roleRareSpeed, roleRareScore)
	local o = Clone(m)

	o:Init(cid, roleRare, roleRareSpeed, roleRareScore)

	return o
end

function m:Init(cid, roleRare, roleRareSpeed, roleRareScore)
	self.cid = cid
	self.roleRare = roleRare
	self.roleRareSpeed = roleRareSpeed
	self.roleRareScore = roleRareScore
end

function m:GetCfgData()
	return CfgAmusementParkDollMachineRoleTable[self.cid]
end

return m
