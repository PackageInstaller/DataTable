-- chunkname: @modules/logic/survival/view/shop/SurvivalShopViewContainer.lua

module("modules.logic.survival.view.shop.SurvivalShopViewContainer", package.seeall)

local SurvivalShopViewContainer = class("SurvivalShopViewContainer", BaseViewContainer)

function SurvivalShopViewContainer:buildViews()
	return {
		SurvivalShopView.New()
	}
end

return SurvivalShopViewContainer
