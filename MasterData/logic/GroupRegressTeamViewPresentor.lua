-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressTeamViewPresentor.lua

module("logic.extensions.groupregress.view.GroupRegressTeamViewPresentor", package.seeall)

local GroupRegressTeamViewPresentor = class("GroupRegressTeamViewPresentor", ViewPresentor)

function GroupRegressTeamViewPresentor:ctor()
	GroupRegressTeamViewPresentor.super.ctor(self)
end

function GroupRegressTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRegressTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/groupregress/groupregressteamview.prefab"
	}
end

function GroupRegressTeamViewPresentor:buildViews()
	return {
		GroupRegressTeamView.New()
	}
end

function GroupRegressTeamViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GroupRegressTeamViewPresentor
