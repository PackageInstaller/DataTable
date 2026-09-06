-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateInviteInfoViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateInviteInfoViewPresentor", package.seeall)

local ShowDownEliminateInviteInfoViewPresentor = class("ShowDownEliminateInviteInfoViewPresentor", ViewPresentor)

function ShowDownEliminateInviteInfoViewPresentor:ctor()
	ShowDownEliminateInviteInfoViewPresentor.super.ctor(self)
end

function ShowDownEliminateInviteInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateInviteInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminateinviteinfoview.prefab"
	}
end

function ShowDownEliminateInviteInfoViewPresentor:buildViews()
	return {
		ShowDownEliminateInviteInfoView.New()
	}
end

return ShowDownEliminateInviteInfoViewPresentor
