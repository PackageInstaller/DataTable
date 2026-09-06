-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassshopViewPresentor.lua

module("logic.extensions.wandererpass.view.WandererpassshopViewPresentor", package.seeall)

local WandererpassshopViewPresentor = class("WandererpassshopViewPresentor", ViewPresentor)

function WandererpassshopViewPresentor:ctor()
	WandererpassshopViewPresentor.super.ctor(self)
end

function WandererpassshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WandererpassshopViewPresentor:dependWhatResources()
	return {
		"ui/views/wandererpass/wandererpassshopview.prefab"
	}
end

function WandererpassshopViewPresentor:buildViews()
	return {
		WandererpassshopView.New()
	}
end

return WandererpassshopViewPresentor
