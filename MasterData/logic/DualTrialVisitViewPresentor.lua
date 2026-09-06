-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialVisitViewPresentor.lua

module("logic.extensions.dualtrial.view.DualTrialVisitViewPresentor", package.seeall)

local DualTrialVisitViewPresentor = class("DualTrialVisitViewPresentor", ViewPresentor)

function DualTrialVisitViewPresentor:ctor()
	DualTrialVisitViewPresentor.super.ctor(self)
end

function DualTrialVisitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualTrialVisitViewPresentor:dependWhatResources()
	return {
		"ui/views/dualtrial/dualtrialvisitview.prefab"
	}
end

function DualTrialVisitViewPresentor:buildViews()
	return {
		DualTrialVisitView.New()
	}
end

return DualTrialVisitViewPresentor
