-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomInjectViewPresentor.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomInjectViewPresentor", package.seeall)

local HelpDragonMomInjectViewPresentor = class("HelpDragonMomInjectViewPresentor", ViewPresentor)

function HelpDragonMomInjectViewPresentor:ctor()
	HelpDragonMomInjectViewPresentor.super.ctor(self)
end

function HelpDragonMomInjectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HelpDragonMomInjectViewPresentor:dependWhatResources()
	return {
		"ui/views/helpdragonmom/helpdragonmominjectview.prefab"
	}
end

function HelpDragonMomInjectViewPresentor:buildViews()
	return {
		HelpDragonMomInjectView.New()
	}
end

return HelpDragonMomInjectViewPresentor
