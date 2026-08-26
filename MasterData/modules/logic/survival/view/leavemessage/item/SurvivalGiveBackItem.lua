-- chunkname: @modules/logic/survival/view/leavemessage/item/SurvivalGiveBackItem.lua

module("modules.logic.survival.view.leavemessage.item.SurvivalGiveBackItem", package.seeall)

local SurvivalGiveBackItem = class("SurvivalGiveBackItem", SimpleListItem)

function SurvivalGiveBackItem:onInit()
	self.survivalBagItem = GameFacade.createLuaComp("survivalmapbagitem", self.viewGO, SurvivalBagItem, nil, self.viewContainer)
end

function SurvivalGiveBackItem:onItemShow(data)
	self.survivalBagItemMo = data

	self.survivalBagItem:updateMo(data)
	self.survivalBagItem:setClickCallback(self.onClickBagItem, self)
end

function SurvivalGiveBackItem:onClickBagItem()
	self:_onClickItem()
end

return SurvivalGiveBackItem
