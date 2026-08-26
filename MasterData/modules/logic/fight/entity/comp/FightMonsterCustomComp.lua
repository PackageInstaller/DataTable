-- chunkname: @modules/logic/fight/entity/comp/FightMonsterCustomComp.lua

module("modules.logic.fight.entity.comp.FightMonsterCustomComp", package.seeall)

local FightMonsterCustomComp = class("FightMonsterCustomComp", LuaCompBase)

FightMonsterCustomComp.Monster2CustomComp = {}

function FightMonsterCustomComp:ctor(entity)
	self.entity = entity
end

function FightMonsterCustomComp:init(go)
	self.go = go

	local entityMo = self.entity:getMO()
	local compCls = FightMonsterCustomComp.Monster2CustomComp[entityMo.modelId]

	if compCls then
		self.customComp = compCls.New(self.entity)

		self.customComp:init(go)
	end
end

function FightMonsterCustomComp:addEventListeners()
	if self.customComp then
		self.customComp:addEventListeners()
	end
end

function FightMonsterCustomComp:removeEventListeners()
	if self.customComp then
		self.customComp:removeEventListeners()
	end
end

function FightMonsterCustomComp:getCustomComp()
	return self.customComp
end

function FightMonsterCustomComp:onDestroy()
	if self.customComp then
		self.customComp:onDestroy()

		self.customComp = nil
	end
end

return FightMonsterCustomComp
