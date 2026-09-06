-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownRankViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownRankViewPresentor", package.seeall)

local ShowDownRankViewPresentor = class("ShowDownRankViewPresentor", ViewPresentor)

function ShowDownRankViewPresentor:ctor()
	ShowDownRankViewPresentor.super.ctor(self)
end

function ShowDownRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownRankViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownrankview.prefab"
	}
end

function ShowDownRankViewPresentor:buildViews()
	return {
		ShowDownRankView.New()
	}
end

return ShowDownRankViewPresentor
