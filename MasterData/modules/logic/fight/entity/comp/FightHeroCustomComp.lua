-- chunkname: @modules/logic/fight/entity/comp/FightHeroCustomComp.lua

module("modules.logic.fight.entity.comp.FightHeroCustomComp", package.seeall)

local FightHeroCustomComp = class("FightHeroCustomComp", FightBaseClass)

FightHeroCustomComp.HeroId2CustomComp = {
	[3113] = FightHeroALFComp,
	[3145] = FightHeroHSYComp
}

function FightHeroCustomComp:onConstructor(entity)
	self.entity = entity

	local go = entity.go

	self.go = go

	local entityMo = self.entity:getMO()
	local compCls = FightHeroCustomComp.HeroId2CustomComp[entityMo.modelId]

	if compCls then
		self.customComp = compCls.New(self.entity)

		self.customComp:init(go)
		self.customComp:addEventListeners()
	end
end

function FightHeroCustomComp:getCustomComp()
	return self.customComp
end

function FightHeroCustomComp:onDestructor()
	if self.customComp then
		self.customComp:removeEventListeners()
		self.customComp:onDestroy()

		self.customComp = nil
	end
end

return FightHeroCustomComp
