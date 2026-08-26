-- chunkname: @modules/logic/fight/entity/comp/heroCustomComp/FightHeroCustomCompBase.lua

module("modules.logic.fight.entity.comp.heroCustomComp.FightHeroCustomCompBase", package.seeall)

local FightHeroCustomCompBase = class("FightHeroCustomCompBase", UserDataDispose)

function FightHeroCustomCompBase:ctor(entity)
	self:__onInit()

	self.entity = entity
end

function FightHeroCustomCompBase:init(go)
	self.go = go
end

function FightHeroCustomCompBase:addEventListeners()
	return
end

function FightHeroCustomCompBase:removeEventListeners()
	return
end

function FightHeroCustomCompBase:onDestroy()
	self:__onDispose()
end

return FightHeroCustomCompBase
