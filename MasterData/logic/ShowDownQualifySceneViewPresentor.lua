-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifySceneViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownQualifySceneViewPresentor", package.seeall)

local ShowDownQualifySceneViewPresentor = class("ShowDownQualifySceneViewPresentor", ViewPresentor)

function ShowDownQualifySceneViewPresentor:ctor()
	ShowDownQualifySceneViewPresentor.super.ctor(self)
end

function ShowDownQualifySceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownQualifySceneViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownqualifysceneview.prefab"
	}
end

function ShowDownQualifySceneViewPresentor:buildViews()
	return {
		ShowDownQualifySceneView.New()
	}
end

function ShowDownQualifySceneViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownQualifySceneViewPresentor
