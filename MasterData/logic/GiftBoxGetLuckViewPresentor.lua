-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxGetLuckViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxGetLuckViewPresentor", package.seeall)

local GiftBoxGetLuckViewPresentor = class("GiftBoxGetLuckViewPresentor", ViewPresentor)

function GiftBoxGetLuckViewPresentor:ctor()
	GiftBoxGetLuckViewPresentor.super.ctor(self)
end

function GiftBoxGetLuckViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxGetLuckViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxgetluckview.prefab"
	}
end

function GiftBoxGetLuckViewPresentor:buildViews()
	return {
		GiftBoxGetLuckView.New()
	}
end

return GiftBoxGetLuckViewPresentor
