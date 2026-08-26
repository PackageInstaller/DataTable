-- chunkname: @modules/logic/fight/fightcomponent/FightObjItemListComponent.lua

module("modules.logic.fight.fightcomponent.FightObjItemListComponent", package.seeall)

local FightObjItemListComponent = class("FightObjItemListComponent", FightBaseClass)

function FightObjItemListComponent:onConstructor()
	return
end

function FightObjItemListComponent:registObjItemList(gameObject, itemClass, parentObject)
	return self:newClass(FightObjItemListItem, gameObject, itemClass, parentObject)
end

function FightObjItemListComponent:registViewItemList(gameObject, itemClass, parentObject)
	return self:newClass(FightViewItemListItem, gameObject, itemClass, parentObject)
end

function FightObjItemListComponent:onDestructor()
	return
end

return FightObjItemListComponent
