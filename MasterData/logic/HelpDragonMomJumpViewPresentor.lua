-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomJumpViewPresentor.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomJumpViewPresentor", package.seeall)

local HelpDragonMomJumpViewPresentor = class("HelpDragonMomJumpViewPresentor", ViewPresentor)

function HelpDragonMomJumpViewPresentor:ctor()
	HelpDragonMomJumpViewPresentor.super.ctor(self)
end

function HelpDragonMomJumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HelpDragonMomJumpViewPresentor:dependWhatResources()
	return {
		"ui/views/helpdragonmom/helpdragonmomjumpview.prefab"
	}
end

function HelpDragonMomJumpViewPresentor:buildViews()
	return {
		HelpDragonMomJumpView.New()
	}
end

return HelpDragonMomJumpViewPresentor
