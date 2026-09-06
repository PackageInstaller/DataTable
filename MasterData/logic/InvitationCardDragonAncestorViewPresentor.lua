-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/InvitationCardDragonAncestorViewPresentor.lua

module("logic.extensions.activitypopup.view.InvitationCardDragonAncestorViewPresentor", package.seeall)

local InvitationCardDragonAncestorViewPresentor = class("InvitationCardDragonAncestorViewPresentor", ViewPresentor)

function InvitationCardDragonAncestorViewPresentor:ctor()
	InvitationCardDragonAncestorViewPresentor.super.ctor(self)
end

function InvitationCardDragonAncestorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InvitationCardDragonAncestorViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/invitationcarddragonancestorview.prefab"
	}
end

function InvitationCardDragonAncestorViewPresentor:buildViews()
	return {
		InvitationCardDragonAncestorView.New()
	}
end

return InvitationCardDragonAncestorViewPresentor
