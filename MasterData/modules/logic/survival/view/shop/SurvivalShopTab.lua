-- chunkname: @modules/logic/survival/view/shop/SurvivalShopTab.lua

module("modules.logic.survival.view.shop.SurvivalShopTab", package.seeall)

local SurvivalShopTab = class("SurvivalShopTab", SimpleListItem)

function SurvivalShopTab:onInit()
	self.image_icon = gohelper.findChildImage(self.viewGO, "#image_icon")
end

function SurvivalShopTab:onItemShow(data)
	self.cfg = data.cfg
	self.tabId = self.cfg.id
	self.context = data.context

	UISpriteSetMgr.instance:setSurvivalSprite(self.image_icon, self.cfg.tabIcon)
end

function SurvivalShopTab:onSelectChange(isSelect)
	local color = self.image_icon.color

	self.image_icon.color = isSelect and Color.New(color.r, color.g, color.b, 1) or Color.New(color.r, color.g, color.b, 0.4)
end

return SurvivalShopTab
