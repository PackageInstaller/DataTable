-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownTeamDetailViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownTeamDetailViewPresentor", package.seeall)

local ShowDownTeamDetailViewPresentor = class("ShowDownTeamDetailViewPresentor", ViewPresentor)

function ShowDownTeamDetailViewPresentor:ctor()
	ShowDownTeamDetailViewPresentor.super.ctor(self)
end

function ShowDownTeamDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownTeamDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownteamdetailview.prefab"
	}
end

function ShowDownTeamDetailViewPresentor:buildViews()
	return {
		ShowDownTeamDetailView.New()
	}
end

return ShowDownTeamDetailViewPresentor
