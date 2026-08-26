-- chunkname: @modules/logic/fight/entity/FightEntityLyTemp.lua

module("modules.logic.fight.entity.FightEntityLyTemp", package.seeall)

local FightEntityLyTemp = class("FightEntityLyTemp", FightEntityTemp)

function FightEntityLyTemp:initComponents()
	self.spine = self:addEntityComponent(FightSpineComp)
	self.spineRenderer = self:addEntityComponent(FightSpineRendererComp)
	self.effect = self:addEntityComponent(FightEffectComp)
end

return FightEntityLyTemp
