-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownMainViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownMainViewPresentor", package.seeall)

local ShowDownMainViewPresentor = class("ShowDownMainViewPresentor", ViewPresentor)

function ShowDownMainViewPresentor:ctor()
	ShowDownMainViewPresentor.super.ctor(self)
end

function ShowDownMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownMainViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownmainview.prefab"
	}
end

function ShowDownMainViewPresentor:buildViews()
	return {
		ShowDownMainView.New()
	}
end

return ShowDownMainViewPresentor
