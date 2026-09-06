-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureShopViewPresentor.lua

module("logic.extensions.sevendays.view.TreasureShopViewPresentor", package.seeall)

local TreasureShopViewPresentor = class("TreasureShopViewPresentor", ViewWithGuidePresentor)

function TreasureShopViewPresentor:ctor()
	TreasureShopViewPresentor.super.ctor(self)
end

function TreasureShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TreasureShopViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/treasureshopview.prefab"
	}
end

function TreasureShopViewPresentor:buildViews()
	return {
		TreasureShopView.New()
	}
end

return TreasureShopViewPresentor
