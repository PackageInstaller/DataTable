-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamInviteViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamInviteViewPresentor", package.seeall)

local FormTeamInviteViewPresentor = class("FormTeamInviteViewPresentor", ViewPresentor)

function FormTeamInviteViewPresentor:ctor()
	FormTeamInviteViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PetManualViewPriority
end

function FormTeamInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormTeamInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteaminviteview.prefab"
	}
end

function FormTeamInviteViewPresentor:buildViews()
	return {
		FormTeamInviteView.New()
	}
end

return FormTeamInviteViewPresentor
