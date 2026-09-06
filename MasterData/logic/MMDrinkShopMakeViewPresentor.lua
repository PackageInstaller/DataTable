-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopMakeViewPresentor.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopMakeViewPresentor", package.seeall)

local MMDrinkShopMakeViewPresentor = class("MMDrinkShopMakeViewPresentor", ViewPresentor)

function MMDrinkShopMakeViewPresentor:ctor()
	MMDrinkShopMakeViewPresentor.super.ctor(self)
end

function MMDrinkShopMakeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMDrinkShopMakeViewPresentor:dependWhatResources()
	return {
		"ui/views/mmdrinkshop/mmdrinkshopmakeview.prefab"
	}
end

function MMDrinkShopMakeViewPresentor:buildViews()
	return {
		MMDrinkShopMakeView.New()
	}
end

return MMDrinkShopMakeViewPresentor
