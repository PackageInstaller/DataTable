-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxMainViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxMainViewPresentor", package.seeall)

local GiftBoxMainViewPresentor = class("GiftBoxMainViewPresentor", ViewPresentor)

function GiftBoxMainViewPresentor:ctor()
	GiftBoxMainViewPresentor.super.ctor(self)
end

function GiftBoxMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GiftBoxMainViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxmainview.prefab"
	}
end

function GiftBoxMainViewPresentor:buildViews()
	return {
		GiftBoxMainView.New()
	}
end

return GiftBoxMainViewPresentor
