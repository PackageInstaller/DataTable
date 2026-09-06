-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressInviteViewPresentor.lua

module("logic.extensions.groupregress.view.GroupRegressInviteViewPresentor", package.seeall)

local GroupRegressInviteViewPresentor = class("GroupRegressInviteViewPresentor", ViewPresentor)

function GroupRegressInviteViewPresentor:ctor()
	GroupRegressInviteViewPresentor.super.ctor(self)
end

function GroupRegressInviteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRegressInviteViewPresentor:dependWhatResources()
	return {
		"ui/views/groupregress/groupregressinviteview.prefab"
	}
end

function GroupRegressInviteViewPresentor:buildViews()
	return {
		GroupRegressInviteView.New()
	}
end

function GroupRegressInviteViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GroupRegressInviteViewPresentor
