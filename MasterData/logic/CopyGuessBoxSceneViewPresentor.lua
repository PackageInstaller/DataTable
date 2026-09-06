-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/guessbox/CopyGuessBoxSceneViewPresentor.lua

module("logic.extensions.suppressgame.view.game.guessbox.CopyGuessBoxSceneViewPresentor", package.seeall)

local CopyGuessBoxSceneViewPresentor = class("CopyGuessBoxSceneViewPresentor", ViewPresentor)

function CopyGuessBoxSceneViewPresentor:ctor()
	CopyGuessBoxSceneViewPresentor.super.ctor(self)
end

function CopyGuessBoxSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CopyGuessBoxSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/guessbox/guessboxsceneview.prefab"
	}
end

function CopyGuessBoxSceneViewPresentor:buildViews()
	return {
		CopyGuessBoxSceneView.New()
	}
end

return CopyGuessBoxSceneViewPresentor
