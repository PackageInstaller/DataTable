-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialMainViewPresentor.lua

module("logic.extensions.dualtrial.view.DualTrialMainViewPresentor", package.seeall)

local DualTrialMainViewPresentor = class("DualTrialMainViewPresentor", ViewPresentor)

function DualTrialMainViewPresentor:ctor()
	DualTrialMainViewPresentor.super.ctor(self)
end

function DualTrialMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualTrialMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dualtrial/dualtrialmainview.prefab"
	}
end

function DualTrialMainViewPresentor:buildViews()
	return {
		DualTrialMainView.New()
	}
end

return DualTrialMainViewPresentor
