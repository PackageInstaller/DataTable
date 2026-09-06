-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateResultViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateResultViewPresentor", package.seeall)

local ShowDownEliminateResultViewPresentor = class("ShowDownEliminateResultViewPresentor", ViewPresentor)

function ShowDownEliminateResultViewPresentor:ctor()
	ShowDownEliminateResultViewPresentor.super.ctor(self)
end

function ShowDownEliminateResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateResultViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminateresultview.prefab"
	}
end

function ShowDownEliminateResultViewPresentor:buildViews()
	return {
		ShowDownEliminateResultView.New()
	}
end

return ShowDownEliminateResultViewPresentor
