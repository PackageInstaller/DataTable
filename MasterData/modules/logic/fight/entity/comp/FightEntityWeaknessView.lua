-- chunkname: @modules/logic/fight/entity/comp/FightEntityWeaknessView.lua

module("modules.logic.fight.entity.comp.FightEntityWeaknessView", package.seeall)

local FightEntityWeaknessView = class("FightEntityWeaknessView", FightBaseClass)

function FightEntityWeaknessView:onConstructor(entity, viewGO)
	self.entity = entity
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.weaknessItem = gohelper.findChild(self.viewGO, "#image_icon")

	self:com_registMsg(FightMsgId.ChangeEntityWeakness, self.onChangeEntityWeakness)
	self:showWeakness()
end

function FightEntityWeaknessView:onChangeEntityWeakness()
	self:showWeakness()
end

function FightEntityWeaknessView:showWeakness()
	local weaknessList = self.entityData.weakCareers
	local hasWeakness = weaknessList and #weaknessList > 0

	gohelper.setActive(self.viewGO, hasWeakness)

	if hasWeakness then
		gohelper.CreateObjList(self, self.onItemShow, weaknessList, self.viewGO, self.weaknessItem)
	end
end

function FightEntityWeaknessView:onItemShow(obj, data, index)
	local image = gohelper.onceAddComponent(obj, gohelper.Type_Image)

	UISpriteSetMgr.instance:setFightSprite(image, "fight_toughness_fighticon_" .. data)
end

return FightEntityWeaknessView
