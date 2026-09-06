-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassmainViewPresentor.lua

module("logic.extensions.wandererpass.view.WandererpassmainViewPresentor", package.seeall)

local WandererpassmainViewPresentor = class("WandererpassmainViewPresentor", ViewPresentor)

function WandererpassmainViewPresentor:ctor()
	WandererpassmainViewPresentor.super.ctor(self)
end

function WandererpassmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WandererpassmainViewPresentor:dependWhatResources()
	return {
		"ui/views/wandererpass/wandererpassmainview.prefab"
	}
end

function WandererpassmainViewPresentor:buildViews()
	return {
		WandererpassmainView.New()
	}
end

return WandererpassmainViewPresentor
