-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleTabViewPresentor.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleTabViewPresentor", package.seeall)

local FashionShowSkinSaleTabViewPresentor = class("FashionShowSkinSaleTabViewPresentor", ViewPresentor)

function FashionShowSkinSaleTabViewPresentor:ctor()
	FashionShowSkinSaleTabViewPresentor.super.ctor(self)
end

function FashionShowSkinSaleTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FashionShowSkinSaleTabViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/multicommoditysaleview.prefab"
	}
end

function FashionShowSkinSaleTabViewPresentor:buildViews()
	return {
		FashionShowSkinSaleTabView.New()
	}
end

return FashionShowSkinSaleTabViewPresentor
