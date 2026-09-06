-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxPrizeShowViewPresentor.lua

module("logic.extensions.giftbox.view.GiftBoxPrizeShowViewPresentor", package.seeall)

local GiftBoxPrizeShowViewPresentor = class("GiftBoxPrizeShowViewPresentor", ViewPresentor)

function GiftBoxPrizeShowViewPresentor:ctor()
	GiftBoxPrizeShowViewPresentor.super.ctor(self)
end

function GiftBoxPrizeShowViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GiftBoxPrizeShowViewPresentor:dependWhatResources()
	return {
		"ui/views/giftbox/giftboxprizeshowview.prefab"
	}
end

function GiftBoxPrizeShowViewPresentor:buildViews()
	return {
		GiftBoxPrizeShowView.New()
	}
end

return GiftBoxPrizeShowViewPresentor
