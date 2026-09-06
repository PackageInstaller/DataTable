-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GrouprechargeteamViewPresentor.lua

module("logic.extensions.grouprecharge.view.GrouprechargeteamViewPresentor", package.seeall)

local GrouprechargeteamViewPresentor = class("GrouprechargeteamViewPresentor", ViewPresentor)

function GrouprechargeteamViewPresentor:ctor()
	GrouprechargeteamViewPresentor.super.ctor(self)
end

function GrouprechargeteamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GrouprechargeteamViewPresentor:dependWhatResources()
	return {
		"ui/views/grouprecharge/grouprechargeteamview.prefab"
	}
end

function GrouprechargeteamViewPresentor:buildViews()
	return {
		GroupRechargeTeamView.New()
	}
end

return GrouprechargeteamViewPresentor
