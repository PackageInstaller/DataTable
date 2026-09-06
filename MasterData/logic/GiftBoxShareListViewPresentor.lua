-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxShareListViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxShareListViewPresentor", package.seeall)

local GiftBoxShareListViewPresentor = class("GiftBoxShareListViewPresentor", ViewPresentor)

function GiftBoxShareListViewPresentor:ctor()
	GiftBoxShareListViewPresentor.super.ctor(self)
end

function GiftBoxShareListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxShareListViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxsharelistview.prefab"
	}
end

function GiftBoxShareListViewPresentor:buildViews()
	return {
		GiftBoxShareListView.New()
	}
end

return GiftBoxShareListViewPresentor
