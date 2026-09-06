-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DressactivityshopViewPresentor.lua

module("logic.extensions.dressactivityshop.view.DressactivityshopViewPresentor", package.seeall)

local DressactivityshopViewPresentor = class("DressactivityshopViewPresentor", ViewPresentor)

function DressactivityshopViewPresentor:ctor()
	DressactivityshopViewPresentor.super.ctor(self)
end

function DressactivityshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DressactivityshopViewPresentor:dependWhatResources()
	return {
		"ui/views/dressactivityshop/dressactivityshopview.prefab"
	}
end

function DressactivityshopViewPresentor:buildViews()
	return {
		DressactivityshopView.New()
	}
end

return DressactivityshopViewPresentor
