-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialPatrolViewPresentor.lua

module("logic.extensions.dualtrial.view.DualTrialPatrolViewPresentor", package.seeall)

local DualTrialPatrolViewPresentor = class("DualTrialPatrolViewPresentor", ViewPresentor)

function DualTrialPatrolViewPresentor:ctor()
	DualTrialPatrolViewPresentor.super.ctor(self)
end

function DualTrialPatrolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualTrialPatrolViewPresentor:dependWhatResources()
	return {
		"ui/views/dualtrial/dualtrialpatrolview.prefab"
	}
end

function DualTrialPatrolViewPresentor:buildViews()
	return {
		DualTrialPatrolView.New()
	}
end

return DualTrialPatrolViewPresentor
