-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEUpdateTeamMemberAttrCommand.lua

local m = {
	SoulCid = 0,
	Power = 0
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(soulCid, attr, power)
	local obj = Clone(m)

	obj:Init(soulCid, attr, power)

	return obj
end

function m:Init(soulCid, attr, power)
	self.SoulCid = soulCid
	self.Attr = attr
	self.Power = power
end

function m.Type()
	return "DTEUpdateTeamMemberAttrCommand"
end

DTEUpdateTeamMemberAttrCommand = m
