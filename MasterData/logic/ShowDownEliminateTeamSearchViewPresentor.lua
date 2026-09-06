-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateTeamSearchViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateTeamSearchViewPresentor", package.seeall)

local ShowDownEliminateTeamSearchViewPresentor = class("ShowDownEliminateTeamSearchViewPresentor", ViewPresentor)

function ShowDownEliminateTeamSearchViewPresentor:ctor()
	ShowDownEliminateTeamSearchViewPresentor.super.ctor(self)
end

function ShowDownEliminateTeamSearchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateTeamSearchViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminateteamsearchview.prefab"
	}
end

function ShowDownEliminateTeamSearchViewPresentor:buildViews()
	return {
		ShowDownEliminateTeamSearchView.New()
	}
end

return ShowDownEliminateTeamSearchViewPresentor
