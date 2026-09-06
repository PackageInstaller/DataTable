-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/games/guessbox/SeasonGuessBoxSceneViewPresentor.lua

module("logic.extensions.season.view.games.guessbox.SeasonGuessBoxSceneViewPresentor", package.seeall)

local SeasonGuessBoxSceneViewPresentor = class("SeasonGuessBoxSceneViewPresentor", ViewPresentor)

function SeasonGuessBoxSceneViewPresentor:ctor()
	SeasonGuessBoxSceneViewPresentor.super.ctor(self)
end

function SeasonGuessBoxSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonGuessBoxSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/guessbox/guessboxsceneview.prefab"
	}
end

function SeasonGuessBoxSceneViewPresentor:buildViews()
	return {
		SeasonGuessBoxSceneView.New()
	}
end

return SeasonGuessBoxSceneViewPresentor
