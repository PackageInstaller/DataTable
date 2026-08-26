-- chunkname: @modules/logic/fight/entity/comp/monsterCustomComp/FightMonsterSmCustomComp.lua

module("modules.logic.fight.entity.comp.monsterCustomComp.FightMonsterSmCustomComp", package.seeall)

local FightMonsterSmCustomComp = class("FightMonsterSmCustomComp", FightMonsterCustomCompBase)

function FightMonsterSmCustomComp:ctor(entity)
	self.entity = entity
end

function FightMonsterSmCustomComp:init(go)
	self.go = go
end

function FightMonsterSmCustomComp:addEventListeners()
	return
end

function FightMonsterSmCustomComp:removeEventListeners()
	return
end

function FightMonsterSmCustomComp:onDestroy()
	return
end

return FightMonsterSmCustomComp
