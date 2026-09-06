-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxTaskViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxTaskViewPresentor", package.seeall)

local GiftBoxTaskViewPresentor = class("GiftBoxTaskViewPresentor", ViewPresentor)

function GiftBoxTaskViewPresentor:ctor()
	GiftBoxTaskViewPresentor.super.ctor(self)
end

function GiftBoxTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxtaskview.prefab"
	}
end

function GiftBoxTaskViewPresentor:buildViews()
	return {
		GiftBoxTaskView.New()
	}
end

return GiftBoxTaskViewPresentor
