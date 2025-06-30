-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEBattleCommand.lua

local m = {
	MonsterCid = 0
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(monsterCid)
	local obj = Clone(m)

	obj:Init(monsterCid)

	return obj
end

function m:Init(monsterCid)
	self.MonsterCid = monsterCid
end

function m.Type()
	return "DTEBattleCommand"
end

DTEBattleCommand = m
