-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScmainViewPresentor.lua

module("logic.extensions.scenariocopy.view.ScmainViewPresentor", package.seeall)

local ScmainViewPresentor = class("ScmainViewPresentor", ViewPresentor)

function ScmainViewPresentor:ctor()
	ScmainViewPresentor.super.ctor(self)
end

function ScmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScmainViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/scmainview.prefab"
	}
end

function ScmainViewPresentor:buildViews()
	return {
		ScmainView.New()
	}
end

return ScmainViewPresentor
