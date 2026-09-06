-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SctrialViewPresentor.lua

module("logic.extensions.scenariocopy.view.SctrialViewPresentor", package.seeall)

local SctrialViewPresentor = class("SctrialViewPresentor", ViewPresentor)

function SctrialViewPresentor:ctor()
	SctrialViewPresentor.super.ctor(self)
end

function SctrialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SctrialViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/sctrialview.prefab"
	}
end

function SctrialViewPresentor:buildViews()
	return {
		SctrialView.New()
	}
end

return SctrialViewPresentor
