-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/TeamMountInviteViewPresentor.lua

module("logic.extensions.mount.view.TeamMountInviteViewPresentor", package.seeall)

local TeamMountInviteViewPresentor = class("TeamMountInviteViewPresentor", ViewPresentor)

function TeamMountInviteViewPresentor:ctor()
	TeamMountInviteViewPresentor.super.ctor(self)
end

function TeamMountInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeamMountInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/mount/teammountinviteview.prefab"
	}
end

function TeamMountInviteViewPresentor:buildViews()
	return {
		TeamMountInviteView.New()
	}
end

return TeamMountInviteViewPresentor
