-- chunkname: @modules/logic/fight/entity/comp/FightSkinCustomComp.lua

module("modules.logic.fight.entity.comp.FightSkinCustomComp", package.seeall)

local FightSkinCustomComp = class("FightSkinCustomComp", FightBaseClass)

FightSkinCustomComp.SkinId2CustomComp = {
	[308603] = FightSkinLuXi_308603CustomComp,
	[630305] = FightSkinSM_630305CustomComp
}

function FightSkinCustomComp:onConstructor(entity)
	self.entity = entity

	local entityMo = self.entity:getMO()

	if entityMo then
		local compCls = FightSkinCustomComp.SkinId2CustomComp[entityMo.skin]

		if compCls then
			self.customComp = compCls.New(self.entity)

			self.customComp:init(entity.go)
			self.customComp:addEventListeners()
		end
	end
end

function FightSkinCustomComp:getCustomComp()
	return self.customComp
end

function FightSkinCustomComp:onDestructor()
	if self.customComp then
		self.customComp:removeEventListeners()
		self.customComp:onDestroy()

		self.customComp = nil
	end
end

return FightSkinCustomComp
