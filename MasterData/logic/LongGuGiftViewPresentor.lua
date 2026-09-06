-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/LongGuGiftViewPresentor.lua

module("logic.extensions.dressactivityshop.view.LongGuGiftViewPresentor", package.seeall)

local LongGuGiftViewPresentor = class("LongGuGiftViewPresentor", ViewPresentor)

function LongGuGiftViewPresentor:ctor()
	LongGuGiftViewPresentor.super.ctor(self)
end

function LongGuGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongGuGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/longgugiftview.prefab"
	}
end

function LongGuGiftViewPresentor:buildViews()
	return {
		LongGuGiftView.New()
	}
end

return LongGuGiftViewPresentor
