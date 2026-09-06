-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressTeamOtherViewPresentor.lua

module("logic.extensions.groupregress.view.GroupRegressTeamOtherViewPresentor", package.seeall)

local GroupRegressTeamOtherViewPresentor = class("GroupRegressTeamOtherViewPresentor", ViewPresentor)

function GroupRegressTeamOtherViewPresentor:ctor()
	GroupRegressTeamOtherViewPresentor.super.ctor(self)
end

function GroupRegressTeamOtherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRegressTeamOtherViewPresentor:dependWhatResources()
	return {
		"ui/views/groupregress/groupregressteamotherview.prefab"
	}
end

function GroupRegressTeamOtherViewPresentor:buildViews()
	return {
		GroupRegressTeamOtherView.New()
	}
end

function GroupRegressTeamOtherViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GroupRegressTeamOtherViewPresentor
