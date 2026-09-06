-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopFinishViewPresentor.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopFinishViewPresentor", package.seeall)

local MMDrinkShopFinishViewPresentor = class("MMDrinkShopFinishViewPresentor", ViewPresentor)

function MMDrinkShopFinishViewPresentor:ctor()
	MMDrinkShopFinishViewPresentor.super.ctor(self)
end

function MMDrinkShopFinishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMDrinkShopFinishViewPresentor:dependWhatResources()
	return {
		"ui/views/mmdrinkshop/mmdrinkshopfinishview.prefab"
	}
end

function MMDrinkShopFinishViewPresentor:buildViews()
	return {
		MMDrinkShopFinishView.New()
	}
end

return MMDrinkShopFinishViewPresentor
