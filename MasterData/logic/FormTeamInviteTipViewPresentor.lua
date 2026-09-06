-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamInviteTipViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamInviteTipViewPresentor", package.seeall)

local FormTeamInviteTipViewPresentor = class("FormTeamInviteTipViewPresentor", ViewPresentor)

function FormTeamInviteTipViewPresentor:ctor()
	FormTeamInviteTipViewPresentor.super.ctor(self)
end

function FormTeamInviteTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function FormTeamInviteTipViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteaminvitetipview.prefab"
	}
end

function FormTeamInviteTipViewPresentor:buildViews()
	return {
		FormTeamInviteTipView.New()
	}
end

function FormTeamInviteTipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FormTeamInviteTipViewPresentor
