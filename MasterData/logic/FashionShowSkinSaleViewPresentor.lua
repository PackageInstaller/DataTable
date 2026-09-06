-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleViewPresentor.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleViewPresentor", package.seeall)

local FashionShowSkinSaleViewPresentor = class("FashionShowSkinSaleViewPresentor", ViewPresentor)

function FashionShowSkinSaleViewPresentor:ctor()
	FashionShowSkinSaleViewPresentor.super.ctor(self)
end

function FashionShowSkinSaleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FashionShowSkinSaleViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/multicommoditysaleview.prefab"
	}
end

function FashionShowSkinSaleViewPresentor:buildViews()
	return {
		FashionShowSkinSaleView.New()
	}
end

return FashionShowSkinSaleViewPresentor
