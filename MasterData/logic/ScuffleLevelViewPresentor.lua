-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleLevelViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleLevelViewPresentor", package.seeall)

local ScuffleLevelViewPresentor = class("ScuffleLevelViewPresentor", ViewPresentor)

function ScuffleLevelViewPresentor:ctor()
	ScuffleLevelViewPresentor.super.ctor(self)
end

function ScuffleLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflelevelview.prefab"
	}
end

function ScuffleLevelViewPresentor:buildViews()
	return {
		ScuffleLevelView.New()
	}
end

return ScuffleLevelViewPresentor
