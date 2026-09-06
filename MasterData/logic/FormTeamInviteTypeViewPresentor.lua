-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamInviteTypeViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamInviteTypeViewPresentor", package.seeall)

local FormTeamInviteTypeViewPresentor = class("FormTeamInviteTypeViewPresentor", ViewPresentor)

function FormTeamInviteTypeViewPresentor:ctor()
	FormTeamInviteTypeViewPresentor.super.ctor(self)
end

function FormTeamInviteTypeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormTeamInviteTypeViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteaminvitetypeview.prefab"
	}
end

function FormTeamInviteTypeViewPresentor:buildViews()
	return {
		FormTeamInviteTypeView.New()
	}
end

return FormTeamInviteTypeViewPresentor
