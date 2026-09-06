-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxTaskChildViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxTaskChildViewPresentor", package.seeall)

local GiftBoxTaskChildViewPresentor = class("GiftBoxTaskChildViewPresentor", ViewPresentor)

function GiftBoxTaskChildViewPresentor:ctor()
	GiftBoxTaskChildViewPresentor.super.ctor(self)
end

function GiftBoxTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxtaskchildview.prefab"
	}
end

function GiftBoxTaskChildViewPresentor:buildViews()
	return {
		GiftBoxTaskChildView.New()
	}
end

return GiftBoxTaskChildViewPresentor
