-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScPerfectPassViewPresentor.lua

module("logic.extensions.scenariocopy.view.ScPerfectPassViewPresentor", package.seeall)

local ScPerfectPassViewPresentor = class("ScPerfectPassViewPresentor", ViewPresentor)

function ScPerfectPassViewPresentor:ctor()
	ScPerfectPassViewPresentor.super.ctor(self)
end

function ScPerfectPassViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ScPerfectPassViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/perfectpassview.prefab"
	}
end

function ScPerfectPassViewPresentor:buildViews()
	return {
		ScPerfectPassView.New()
	}
end

return ScPerfectPassViewPresentor
