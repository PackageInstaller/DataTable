-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleGodGemViewPresentor.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleGodGemViewPresentor", package.seeall)

local FashionShowSkinSaleGodGemViewPresentor = class("FashionShowSkinSaleGodGemViewPresentor", ViewPresentor)

function FashionShowSkinSaleGodGemViewPresentor:ctor()
	FashionShowSkinSaleGodGemViewPresentor.super.ctor(self)
end

function FashionShowSkinSaleGodGemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FashionShowSkinSaleGodGemViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/multicommodityothersaleview.prefab"
	}
end

function FashionShowSkinSaleGodGemViewPresentor:buildViews()
	return {
		FashionShowSkinSaleGodGemView.New()
	}
end

return FashionShowSkinSaleGodGemViewPresentor
