-- chunkname: @modules/logic/fight/entity/comp/FightFocusHpKillLineComp.lua

module("modules.logic.fight.entity.comp.FightFocusHpKillLineComp", package.seeall)

local FightFocusHpKillLineComp = class("FightFocusHpKillLineComp", FightHpKillLineComp)

function FightFocusHpKillLineComp:init(containerGo)
	self:__onInit()

	self.loadStatus = FightHpKillLineComp.LoadStatus.NotLoaded
	self.containerGo = containerGo
	self.containerWidth = recthelper.getWidth(self.containerGo:GetComponent(gohelper.Type_RectTransform))

	self:loadRes()
end

function FightFocusHpKillLineComp:refreshByEntityMo(entityMo)
	self.entityMo = entityMo
	self.entityId = entityMo.id

	self:updateKillLine()
end

return FightFocusHpKillLineComp
