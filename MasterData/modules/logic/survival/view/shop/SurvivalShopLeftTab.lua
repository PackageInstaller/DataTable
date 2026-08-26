-- chunkname: @modules/logic/survival/view/shop/SurvivalShopLeftTab.lua

module("modules.logic.survival.view.shop.SurvivalShopLeftTab", package.seeall)

local SurvivalShopLeftTab = class("SurvivalShopLeftTab", SimpleListItem)

function SurvivalShopLeftTab:onInit()
	self.image_icon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self.image_icon.color = Color.New(1, 1, 1, 0.4)
end

function SurvivalShopLeftTab:onItemShow(data)
	self.bagType = data

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.bag = weekInfo:getBag(self.bagType)
end

function SurvivalShopLeftTab:onSelectChange(isSelect)
	local color = self.image_icon.color

	self.image_icon.color = isSelect and Color.New(color.r, color.g, color.b, 1) or Color.New(color.r, color.g, color.b, 0.4)
end

return SurvivalShopLeftTab
