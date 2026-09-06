-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialAfkViewPresentor.lua

module("logic.extensions.dualtrial.view.DualTrialAfkViewPresentor", package.seeall)

local DualTrialAfkViewPresentor = class("DualTrialAfkViewPresentor", ViewPresentor)

function DualTrialAfkViewPresentor:ctor()
	DualTrialAfkViewPresentor.super.ctor(self)
end

function DualTrialAfkViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualTrialAfkViewPresentor:dependWhatResources()
	return {
		"ui/views/dualtrial/dualtrialafkview.prefab"
	}
end

function DualTrialAfkViewPresentor:buildViews()
	return {
		DualTrialAfkView.New()
	}
end

return DualTrialAfkViewPresentor
