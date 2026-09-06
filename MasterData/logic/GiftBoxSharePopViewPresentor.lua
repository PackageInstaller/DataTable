-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxSharePopViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxSharePopViewPresentor", package.seeall)

local GiftBoxSharePopViewPresentor = class("GiftBoxSharePopViewPresentor", ViewPresentor)

function GiftBoxSharePopViewPresentor:ctor()
	GiftBoxSharePopViewPresentor.super.ctor(self)
end

function GiftBoxSharePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxSharePopViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxsharepopview.prefab"
	}
end

function GiftBoxSharePopViewPresentor:buildViews()
	return {
		GiftBoxSharePopView.New()
	}
end

return GiftBoxSharePopViewPresentor
