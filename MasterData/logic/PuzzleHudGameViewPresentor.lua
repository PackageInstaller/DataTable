-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/view/PuzzleHudGameViewPresentor.lua

module("logic.extensions.puzzlegame.view.PuzzleHudGameViewPresentor", package.seeall)

local PuzzleHudGameViewPresentor = class("PuzzleHudGameViewPresentor", ViewPresentor)

function PuzzleHudGameViewPresentor:ctor()
	PuzzleHudGameViewPresentor.super.ctor(self)
end

function PuzzleHudGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PuzzleHudGameViewPresentor:dependWhatResources()
	return {
		"ui/views/puzzlegamehud/puzzlehudgameview.prefab"
	}
end

function PuzzleHudGameViewPresentor:buildViews()
	return {
		PuzzleHudGameView.New()
	}
end

return PuzzleHudGameViewPresentor
