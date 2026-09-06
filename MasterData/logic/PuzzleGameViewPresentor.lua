-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/view/PuzzleGameViewPresentor.lua

module("logic.extensions.puzzlegame.view.PuzzleGameViewPresentor", package.seeall)

local PuzzleGameViewPresentor = class("PuzzleGameViewPresentor", ViewPresentor)

function PuzzleGameViewPresentor:ctor()
	PuzzleGameViewPresentor.super.ctor(self)
end

function PuzzleGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PuzzleGameViewPresentor:dependWhatResources()
	return {
		"ui/views/puzzlegamehud/puzzlegamehudview.prefab"
	}
end

function PuzzleGameViewPresentor:buildViews()
	return {
		PuzzleGameHudView.New()
	}
end

return PuzzleGameViewPresentor
