-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldShopViewPresentor.lua

module("logic.extensions.uniqueworld.view.UniqueWorldShopViewPresentor", package.seeall)

local UniqueWorldShopViewPresentor = class("UniqueWorldShopViewPresentor", ViewPresentor)

function UniqueWorldShopViewPresentor:ctor()
	UniqueWorldShopViewPresentor.super.ctor(self)
end

function UniqueWorldShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UniqueWorldShopViewPresentor:dependWhatResources()
	return {
		"ui/views/uniqueworld/uniqueworldshopview.prefab"
	}
end

function UniqueWorldShopViewPresentor:buildViews()
	return {
		UniqueWorldShopView.New()
	}
end

return UniqueWorldShopViewPresentor
