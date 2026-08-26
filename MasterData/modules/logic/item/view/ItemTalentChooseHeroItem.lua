-- chunkname: @modules/logic/item/view/ItemTalentChooseHeroItem.lua

module("modules.logic.item.view.ItemTalentChooseHeroItem", package.seeall)

local ItemTalentChooseHeroItem = class("ItemTalentChooseHeroItem", LuaCompBase)

function ItemTalentChooseHeroItem:init(go)
	self.go = go
	self._imagerare = gohelper.findChildImage(go, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(go, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(go, "role/career")
	self._txtname = gohelper.findChildText(go, "role/name")
	self._goexskill = gohelper.findChildImage(go, "role/go_exskill")
	self._gorank = gohelper.findChild(go, "role/go_ranks")
	self._goselect = gohelper.findChild(go, "select")
	self._goclick = gohelper.findChild(go, "go_click")
	self._itemClick = gohelper.getClickWithAudio(self._goclick)

	self._itemClick:AddClickListener(self._itemClickOnClick, self)
	gohelper.setActive(self._goexskill, false)
	gohelper.setActive(self._gorank, false)
end

function ItemTalentChooseHeroItem:_itemClickOnClick()
	if self._isScan then
		return
	end

	local curHeroId = ItemTalentModel.instance:getCurSelectHero()

	if curHeroId == self._heroMO.heroId then
		return
	end

	ItemTalentModel.instance:setCurSelectHero(self._heroMO.heroId)
	ItemTalentController.instance:dispatchEvent(ItemTalentEvent.ChooseHeroItem)
end

function ItemTalentChooseHeroItem:_refreshHeroItem()
	self._txtname.text = "Lv.<size=40>" .. tostring(self._heroMO.talent)

	local config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Hero, self._heroMO.heroId)

	self._simageicon:LoadImage(icon)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. CharacterEnum.Color[config.rare])
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. config.career)

	local curHeroId = ItemTalentModel.instance:getCurSelectHero()

	gohelper.setActive(self._goselect, curHeroId == self._heroMO.heroId)
end

function ItemTalentChooseHeroItem:refresh(heroMo, isScan)
	gohelper.setActive(self.go, true)

	self._heroMO = heroMo
	self._isScan = not isScan

	self:_refreshHeroItem()
end

function ItemTalentChooseHeroItem:destroy()
	self._itemClick:RemoveClickListener()
end

return ItemTalentChooseHeroItem
