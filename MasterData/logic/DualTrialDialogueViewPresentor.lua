-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialDialogueViewPresentor.lua

module("logic.extensions.dualtrial.view.DualTrialDialogueViewPresentor", package.seeall)

local DualTrialDialogueViewPresentor = class("DualTrialDialogueViewPresentor", ViewPresentor)

function DualTrialDialogueViewPresentor:ctor()
	DualTrialDialogueViewPresentor.super.ctor(self)
end

function DualTrialDialogueViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualTrialDialogueViewPresentor:dependWhatResources()
	return {
		"ui/views/dualtrial/dualtrialdialogueview.prefab"
	}
end

function DualTrialDialogueViewPresentor:buildViews()
	return {
		DualTrialDialogueView.New()
	}
end

return DualTrialDialogueViewPresentor
