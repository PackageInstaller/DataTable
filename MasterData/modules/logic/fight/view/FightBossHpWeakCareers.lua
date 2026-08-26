-- chunkname: @modules/logic/fight/view/FightBossHpWeakCareers.lua

module("modules.logic.fight.view.FightBossHpWeakCareers", package.seeall)

local FightBossHpWeakCareers = class("FightBossHpWeakCareers", FightBaseClass)

function FightBossHpWeakCareers:onConstructor(viewGO, entityData)
	self.viewGO = viewGO
	self.entityData = entityData
	self.weaknessItem = gohelper.findChild(self.viewGO, "#image_icon")

	self:com_registMsg(FightMsgId.ChangeEntityWeakness, self.showWeakCareers)
	self:com_registMsg(FightMsgId.AfterDestroyEntity, self.onAfterDestroyEntity)
	self:showWeakCareers()
end

function FightBossHpWeakCareers:showWeakCareers()
	local weaknessList = self.entityData.weakCareers
	local hasWeakness = weaknessList and #weaknessList > 0

	gohelper.setActive(self.viewGO, hasWeakness)

	if hasWeakness then
		gohelper.CreateObjList(self, self.onItemShow, weaknessList, self.viewGO, self.weaknessItem)
	end
end

function FightBossHpWeakCareers:onItemShow(obj, data, index)
	local image = gohelper.onceAddComponent(obj, gohelper.Type_Image)

	UISpriteSetMgr.instance:setFightSprite(image, "fight_toughness_fighticon_" .. data)
end

function FightBossHpWeakCareers:onAfterDestroyEntity(entityID)
	if entityID == self.entityData.id then
		gohelper.setActive(self.viewGO, false)
		self:disposeSelf()
	end
end

return FightBossHpWeakCareers
