-- chunkname: @modules/logic/fight/fightcomponent/FightViewItemListItem.lua

module("modules.logic.fight.fightcomponent.FightViewItemListItem", package.seeall)

local FightViewItemListItem = class("FightViewItemListItem", FightObjItemListItem)

function FightViewItemListItem:newItem()
	local item = FightViewItemListItem.super.newItem(self)
	local PARENT_VIEW = self.PARENT_ROOT_OBJECT.PARENT_ROOT_OBJECT

	item.viewName = PARENT_VIEW.viewName
	item.viewContainer = PARENT_VIEW.viewContainer
	item.PARENT_VIEW = PARENT_VIEW
	item.viewGO = item.GAMEOBJECT

	item:inner_startView()

	return item
end

return FightViewItemListItem
