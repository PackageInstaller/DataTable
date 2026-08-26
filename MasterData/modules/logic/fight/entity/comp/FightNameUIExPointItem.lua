-- chunkname: @modules/logic/fight/entity/comp/FightNameUIExPointItem.lua

module("modules.logic.fight.entity.comp.FightNameUIExPointItem", package.seeall)

local FightNameUIExPointItem = class("FightNameUIExPointItem", FightNameUIExPointBaseItem)

function FightNameUIExPointItem.GetExPointItem(exPointGo)
	local pointItem = FightNameUIExPointItem.New()

	pointItem:init(exPointGo)

	return pointItem
end

function FightNameUIExPointItem:getType()
	return FightNameUIExPointItem.ExPointType.Normal
end

function FightNameUIExPointItem:init(exPointGo)
	FightNameUIExPointItem.super.init(self, exPointGo)

	self.goFull2 = gohelper.findChild(self.exPointGo, "full2")
	self.imageFull2 = self.goFull2:GetComponent(gohelper.Type_Image)
end

function FightNameUIExPointItem:resetToEmpty()
	FightNameUIExPointItem.super.resetToEmpty(self)
	gohelper.setActive(self.goFull2, false)

	self.imageFull2.color = Color.white
end

function FightNameUIExPointItem:directSetStoredState(preState)
	FightNameUIExPointItem.super.directSetStoredState(self)
	gohelper.setActive(self.goFull2, true)
end

function FightNameUIExPointItem:switchToStoredState(preState)
	FightNameUIExPointItem.super.switchToStoredState(self)
	gohelper.setActive(self.goFull2, true)
end

return FightNameUIExPointItem
