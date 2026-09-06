-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassgiftlistViewPresentor.lua

module("logic.extensions.wandererpass.view.WandererpassgiftlistViewPresentor", package.seeall)

local WandererpassgiftlistViewPresentor = class("WandererpassgiftlistViewPresentor", ViewPresentor)

function WandererpassgiftlistViewPresentor:ctor()
	WandererpassgiftlistViewPresentor.super.ctor(self)
end

function WandererpassgiftlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WandererpassgiftlistViewPresentor:dependWhatResources()
	return {
		"ui/views/wandererpass/wandererpassgiftlistview.prefab"
	}
end

function WandererpassgiftlistViewPresentor:buildViews()
	return {
		WandererpassgiftlistView.New()
	}
end

return WandererpassgiftlistViewPresentor
