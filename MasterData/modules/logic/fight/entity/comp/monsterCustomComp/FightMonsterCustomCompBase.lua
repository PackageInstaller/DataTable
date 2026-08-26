-- chunkname: @modules/logic/fight/entity/comp/monsterCustomComp/FightMonsterCustomCompBase.lua

module("modules.logic.fight.entity.comp.monsterCustomComp.FightMonsterCustomCompBase", package.seeall)

local FightMonsterCustomCompBase = class("FightMonsterCustomCompBase")

function FightMonsterCustomCompBase:ctor(entity)
	self.entity = entity
end

function FightMonsterCustomCompBase:init(go)
	self.go = go
end

function FightMonsterCustomCompBase:addEventListeners()
	return
end

function FightMonsterCustomCompBase:removeEventListeners()
	return
end

function FightMonsterCustomCompBase:onDestroy()
	return
end

return FightMonsterCustomCompBase
