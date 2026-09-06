-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmdrinkshop/view/MMDrinkShopUnlockViewPresentor.lua

module("logic.extensions.mmdrinkshop.view.MMDrinkShopUnlockViewPresentor", package.seeall)

local MMDrinkShopUnlockViewPresentor = class("MMDrinkShopUnlockViewPresentor", ViewPresentor)

function MMDrinkShopUnlockViewPresentor:ctor()
	MMDrinkShopUnlockViewPresentor.super.ctor(self)
end

function MMDrinkShopUnlockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMDrinkShopUnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/mmdrinkshop/mmdrinkshopunlockview.prefab"
	}
end

function MMDrinkShopUnlockViewPresentor:buildViews()
	return {
		MMDrinkShopUnlockView.New()
	}
end

return MMDrinkShopUnlockViewPresentor
