-- chunkname: @modules/logic/fight/entity/comp/FightBossHpKillLineComp.lua

module("modules.logic.fight.entity.comp.FightBossHpKillLineComp", package.seeall)

local FightBossHpKillLineComp = class("FightBossHpKillLineComp", FightHpKillLineComp)

function FightBossHpKillLineComp:init(containerGo)
	self:__onInit()

	self.loadStatus = FightHpKillLineComp.LoadStatus.NotLoaded
	self.containerGo = containerGo
	self.containerWidth = recthelper.getWidth(self.containerGo:GetComponent(gohelper.Type_RectTransform))

	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)
end

function FightBossHpKillLineComp:refreshByEntityMo(entityMo)
	if not entityMo then
		self.entityMo = nil
		self.entityId = nil

		self:updateKillLine()

		return
	end

	self.entityMo = entityMo
	self.entityId = entityMo.id

	if self.loadStatus == FightHpKillLineComp.LoadStatus.Loaded then
		self:updateKillLine()

		return
	end

	if self.loadStatus == FightHpKillLineComp.LoadStatus.NotLoaded then
		self:loadRes()

		return
	end
end

return FightBossHpKillLineComp
