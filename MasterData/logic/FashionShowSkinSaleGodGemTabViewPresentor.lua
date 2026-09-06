-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleGodGemTabViewPresentor.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleGodGemTabViewPresentor", package.seeall)

local FashionShowSkinSaleGodGemTabViewPresentor = class("FashionShowSkinSaleGodGemTabViewPresentor", ViewPresentor)

function FashionShowSkinSaleGodGemTabViewPresentor:ctor()
	FashionShowSkinSaleGodGemTabViewPresentor.super.ctor(self)
end

function FashionShowSkinSaleGodGemTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FashionShowSkinSaleGodGemTabViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/multicommodityothersaleview.prefab"
	}
end

function FashionShowSkinSaleGodGemTabViewPresentor:buildViews()
	return {
		FashionShowSkinSaleGodGemTabView.New()
	}
end

return FashionShowSkinSaleGodGemTabViewPresentor
