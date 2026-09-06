-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxHighLuckTipViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxHighLuckTipViewPresentor", package.seeall)

local GiftBoxHighLuckTipViewPresentor = class("GiftBoxHighLuckTipViewPresentor", ViewPresentor)

function GiftBoxHighLuckTipViewPresentor:ctor()
	GiftBoxHighLuckTipViewPresentor.super.ctor(self)
end

function GiftBoxHighLuckTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxHighLuckTipViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxhighlucktipview.prefab"
	}
end

function GiftBoxHighLuckTipViewPresentor:buildViews()
	return {
		GiftBoxHighLuckTipView.New()
	}
end

return GiftBoxHighLuckTipViewPresentor
