-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownbeinviteViewPresentor.lua

module("logic.extensions.showdown.view.ShowdownbeinviteViewPresentor", package.seeall)

local ShowdownbeinviteViewPresentor = class("ShowdownbeinviteViewPresentor", ViewPresentor)

function ShowdownbeinviteViewPresentor:ctor()
	ShowdownbeinviteViewPresentor.super.ctor(self)
end

function ShowdownbeinviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowdownbeinviteViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownbeinviteview.prefab"
	}
end

function ShowdownbeinviteViewPresentor:buildViews()
	return {
		ShowdownbeinviteView.New()
	}
end

return ShowdownbeinviteViewPresentor
