-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressInvitePopViewPresentor.lua

module("logic.extensions.groupregress.view.GroupRegressInvitePopViewPresentor", package.seeall)

local GroupRegressInvitePopViewPresentor = class("GroupRegressInvitePopViewPresentor", ViewPresentor)

function GroupRegressInvitePopViewPresentor:ctor()
	GroupRegressInvitePopViewPresentor.super.ctor(self)
end

function GroupRegressInvitePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GroupRegressInvitePopViewPresentor:dependWhatResources()
	return {
		"ui/views/groupregress/groupregressinvitepopview.prefab"
	}
end

function GroupRegressInvitePopViewPresentor:buildViews()
	return {
		GroupRegressInvitePopView.New()
	}
end

return GroupRegressInvitePopViewPresentor
