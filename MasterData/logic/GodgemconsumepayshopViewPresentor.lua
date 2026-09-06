-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumepayshopViewPresentor.lua

module("logic.extensions.godgemconsume.view.GodgemconsumepayshopViewPresentor", package.seeall)

local GodgemconsumepayshopViewPresentor = class("GodgemconsumepayshopViewPresentor", ViewPresentor)

function GodgemconsumepayshopViewPresentor:ctor()
	GodgemconsumepayshopViewPresentor.super.ctor(self)
end

function GodgemconsumepayshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodgemconsumepayshopViewPresentor:dependWhatResources()
	return {
		"ui/views/godgemconsume/godgemconsumepayshopview.prefab"
	}
end

function GodgemconsumepayshopViewPresentor:buildViews()
	return {
		GodgemconsumepayshopView.New()
	}
end

return GodgemconsumepayshopViewPresentor
