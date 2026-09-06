-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/GiftPackSaleGodGemViewPresentor.lua

module("logic.extensions.dressactivityshop.view.GiftPackSaleGodGemViewPresentor", package.seeall)

local GiftPackSaleGodGemViewPresentor = class("GiftPackSaleGodGemViewPresentor", ViewPresentor)

function GiftPackSaleGodGemViewPresentor:ctor()
	GiftPackSaleGodGemViewPresentor.super.ctor(self)
end

function GiftPackSaleGodGemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GiftPackSaleGodGemViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/giftpacksalegodgemview.prefab"
	}
end

function GiftPackSaleGodGemViewPresentor:buildViews()
	return {
		GiftPackSaleGodGemView.New()
	}
end

return GiftPackSaleGodGemViewPresentor
