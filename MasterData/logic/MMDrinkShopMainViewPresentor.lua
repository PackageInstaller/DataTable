-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopMainViewPresentor.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopMainViewPresentor", package.seeall)

local MMDrinkShopMainViewPresentor = class("MMDrinkShopMainViewPresentor", ViewPresentor)

function MMDrinkShopMainViewPresentor:ctor()
	MMDrinkShopMainViewPresentor.super.ctor(self)
end

function MMDrinkShopMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMDrinkShopMainViewPresentor:dependWhatResources()
	return {
		"ui/views/mmdrinkshop/mmdrinkshopmainview.prefab"
	}
end

function MMDrinkShopMainViewPresentor:buildViews()
	return {
		MMDrinkShopMainView.New()
	}
end

return MMDrinkShopMainViewPresentor
