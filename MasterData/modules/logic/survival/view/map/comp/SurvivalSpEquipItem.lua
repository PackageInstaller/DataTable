-- chunkname: @modules/logic/survival/view/map/comp/SurvivalSpEquipItem.lua

module("modules.logic.survival.view.map.comp.SurvivalSpEquipItem", package.seeall)

local SurvivalSpEquipItem = class("SurvivalSpEquipItem", SurvivalEquipItem)

function SurvivalSpEquipItem:init(go)
	self._imageRare = gohelper.findChildImage(go, "#go_drag/item/#image_rare")
	self._imageIcon = gohelper.findChildSingleImage(go, "#go_drag/item/simage_Icon")
	self._goEffect6 = gohelper.findChild(go, "#go_drag/item/#go_deceffect")
	self._goTag = gohelper.findChild(go, "#go_drag/item/go_tag")

	SurvivalSpEquipItem.super.init(self, go)
end

function SurvivalSpEquipItem:updateItemMo()
	UISpriteSetMgr.instance:setSurvivalSprite(self._imageRare, "survival_bag_itemquality3_" .. self.mo.item.co.rare)
	self._imageIcon:LoadImage(ResUrl.getSurvivalItemIcon(self.mo.item.co.icon))
	gohelper.setActive(self._goEffect6, self.mo.item.co.rare == 6)
	gohelper.setActive(self._goTag, self.mo.item.bagReason == 1)
end

return SurvivalSpEquipItem
