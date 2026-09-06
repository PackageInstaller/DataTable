-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSceneViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSceneViewPresentor", package.seeall)

local NumberPuzzleGameSceneViewPresentor = class("NumberPuzzleGameSceneViewPresentor", ViewPresentor)

function NumberPuzzleGameSceneViewPresentor:ctor()
	NumberPuzzleGameSceneViewPresentor.super.ctor(self)
end

function NumberPuzzleGameSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberPuzzleGameSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamesceneview.prefab"
	}
end

function NumberPuzzleGameSceneViewPresentor:buildViews()
	return {
		NumberPuzzleGameSceneView.New()
	}
end

return NumberPuzzleGameSceneViewPresentor
