-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxSceneViewPresentor.lua

module("logic.extensions.guessbox.view.GuessBoxSceneViewPresentor", package.seeall)

local GuessBoxSceneViewPresentor = class("GuessBoxSceneViewPresentor", ViewPresentor)

function GuessBoxSceneViewPresentor:ctor()
	GuessBoxSceneViewPresentor.super.ctor(self)
end

function GuessBoxSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessBoxSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/guessbox/guessboxsceneview.prefab"
	}
end

function GuessBoxSceneViewPresentor:buildViews()
	return {
		GuessBoxSceneView.New()
	}
end

return GuessBoxSceneViewPresentor
