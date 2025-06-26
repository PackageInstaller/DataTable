-- chunkname: @IQIGame\\Module\\GhostGame\\GhostEnemyData.lua

local m = {}

function m.New(monsterCfg)
	local obj = Clone(m)

	obj:Init(monsterCfg)

	return obj
end

function m:Init(monsterCfg)
	self.monsterCfg = monsterCfg
	self.enemyCid = self.monsterCfg.Id

	self:InitBaseAttr()
end

function m:InitBaseAttr()
	self.speed = self.monsterCfg.MonsterSpeed
	self.hp = self.monsterCfg.MonsterHP
	self.type = self.monsterCfg.MonsterType
	self.defaultBuff = GhostGameModule.RandomBuff(self.monsterCfg)
end

function m:UpdateSpeed()
	return
end

function m:UpdateHp(hp)
	self.hp = self.hp - hp

	return self.hp
end

function m:IsDead()
	return self.hp <= 0
end

function m:Dispose()
	return
end

return m
