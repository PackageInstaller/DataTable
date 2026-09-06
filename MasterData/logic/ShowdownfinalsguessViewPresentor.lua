-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownfinalsguessViewPresentor.lua

module("logic.extensions.showdown.view.ShowdownfinalsguessViewPresentor", package.seeall)

local ShowdownfinalsguessViewPresentor = class("ShowdownfinalsguessViewPresentor", ViewPresentor)

function ShowdownfinalsguessViewPresentor:ctor()
	ShowdownfinalsguessViewPresentor.super.ctor(self)
end

function ShowdownfinalsguessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowdownfinalsguessViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalsguessview.prefab"
	}
end

function ShowdownfinalsguessViewPresentor:buildViews()
	return {
		ShowdownfinalsguessView.New()
	}
end

return ShowdownfinalsguessViewPresentor
