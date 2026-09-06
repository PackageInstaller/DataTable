-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialFightViewPresentor.lua

module("logic.extensions.dualtrial.view.DualTrialFightViewPresentor", package.seeall)

local DualTrialFightViewPresentor = class("DualTrialFightViewPresentor", ViewPresentor)

function DualTrialFightViewPresentor:ctor()
	DualTrialFightViewPresentor.super.ctor(self)
end

function DualTrialFightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualTrialFightViewPresentor:dependWhatResources()
	return {
		"ui/views/dualtrial/dualtrialfightview.prefab"
	}
end

function DualTrialFightViewPresentor:buildViews()
	return {
		DualTrialFightView.New()
	}
end

return DualTrialFightViewPresentor
