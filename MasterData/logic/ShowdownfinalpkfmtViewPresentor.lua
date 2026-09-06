-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownfinalpkfmtViewPresentor.lua

module("logic.extensions.showdown.view.ShowdownfinalpkfmtViewPresentor", package.seeall)

local ShowdownfinalpkfmtViewPresentor = class("ShowdownfinalpkfmtViewPresentor", ViewPresentor)

function ShowdownfinalpkfmtViewPresentor:ctor()
	ShowdownfinalpkfmtViewPresentor.super.ctor(self)
end

function ShowdownfinalpkfmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowdownfinalpkfmtViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalpkfmtview.prefab"
	}
end

function ShowdownfinalpkfmtViewPresentor:buildViews()
	return {
		ShowdownfinalpkfmtView.New()
	}
end

return ShowdownfinalpkfmtViewPresentor
