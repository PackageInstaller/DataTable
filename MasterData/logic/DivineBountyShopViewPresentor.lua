-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/view/DivineBountyShopViewPresentor.lua

module("logic.extensions.divinebounty.view.DivineBountyShopViewPresentor", package.seeall)

local DivineBountyShopViewPresentor = class("DivineBountyShopViewPresentor", ViewPresentor)

function DivineBountyShopViewPresentor:ctor()
	DivineBountyShopViewPresentor.super.ctor(self)
end

function DivineBountyShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineBountyShopViewPresentor:dependWhatResources()
	return {
		"ui/views/divinebounty/divinebountyshopview.prefab"
	}
end

function DivineBountyShopViewPresentor:buildViews()
	return {
		DivineBountyShopView.New()
	}
end

return DivineBountyShopViewPresentor
