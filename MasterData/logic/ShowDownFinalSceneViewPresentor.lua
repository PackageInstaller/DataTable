-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalSceneViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFinalSceneViewPresentor", package.seeall)

local ShowDownFinalSceneViewPresentor = class("ShowDownFinalSceneViewPresentor", ViewPresentor)

function ShowDownFinalSceneViewPresentor:ctor()
	ShowDownFinalSceneViewPresentor.super.ctor(self)
end

function ShowDownFinalSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFinalSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalsceneview.prefab"
	}
end

function ShowDownFinalSceneViewPresentor:buildViews()
	return {
		ShowDownFinalSceneView.New()
	}
end

function ShowDownFinalSceneViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownFinalSceneViewPresentor
