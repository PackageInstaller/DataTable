-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateSceneViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateSceneViewPresentor", package.seeall)

local ShowDownEliminateSceneViewPresentor = class("ShowDownEliminateSceneViewPresentor", ViewPresentor)

function ShowDownEliminateSceneViewPresentor:ctor()
	ShowDownEliminateSceneViewPresentor.super.ctor(self)
end

function ShowDownEliminateSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminatesceneview.prefab"
	}
end

function ShowDownEliminateSceneViewPresentor:buildViews()
	return {
		ShowDownEliminateSceneView.New()
	}
end

function ShowDownEliminateSceneViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownEliminateSceneViewPresentor
