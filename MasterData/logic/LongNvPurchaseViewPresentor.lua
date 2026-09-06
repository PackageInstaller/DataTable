-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/LongNvPurchaseViewPresentor.lua

module("logic.extensions.directpurchase.view.LongNvPurchaseViewPresentor", package.seeall)

local LongNvPurchaseViewPresentor = class("LongNvPurchaseViewPresentor", ViewPresentor)

function LongNvPurchaseViewPresentor:ctor()
	LongNvPurchaseViewPresentor.super.ctor(self)
end

function LongNvPurchaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongNvPurchaseViewPresentor:dependWhatResources()
	return {
		"ui/views/longnvpurchase/longnvpurchaseview.prefab"
	}
end

function LongNvPurchaseViewPresentor:buildViews()
	return {
		LongNvPurchaseView.New()
	}
end

return LongNvPurchaseViewPresentor
