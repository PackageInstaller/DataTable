-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxLowLuckTipViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxLowLuckTipViewPresentor", package.seeall)

local GiftBoxLowLuckTipViewPresentor = class("GiftBoxLowLuckTipViewPresentor", ViewPresentor)

function GiftBoxLowLuckTipViewPresentor:ctor()
	GiftBoxLowLuckTipViewPresentor.super.ctor(self)
end

function GiftBoxLowLuckTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxLowLuckTipViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxlowlucktipview.prefab"
	}
end

function GiftBoxLowLuckTipViewPresentor:buildViews()
	return {
		GiftBoxLowLuckTipView.New()
	}
end

return GiftBoxLowLuckTipViewPresentor
