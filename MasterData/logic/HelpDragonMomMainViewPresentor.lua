-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomMainViewPresentor.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomMainViewPresentor", package.seeall)

local HelpDragonMomMainViewPresentor = class("HelpDragonMomMainViewPresentor", ViewPresentor)

function HelpDragonMomMainViewPresentor:ctor()
	HelpDragonMomMainViewPresentor.super.ctor(self)
end

function HelpDragonMomMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HelpDragonMomMainViewPresentor:dependWhatResources()
	return {
		"ui/views/helpdragonmom/helpdragonmommainview.prefab"
	}
end

function HelpDragonMomMainViewPresentor:buildViews()
	return {
		HelpDragonMomMainView.New()
	}
end

return HelpDragonMomMainViewPresentor
