-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSuperRankViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSuperRankViewPresentor", package.seeall)

local NumberPuzzleGameSuperRankViewPresentor = class("NumberPuzzleGameSuperRankViewPresentor", ViewPresentor)

function NumberPuzzleGameSuperRankViewPresentor:ctor()
	NumberPuzzleGameSuperRankViewPresentor.super.ctor(self)
end

function NumberPuzzleGameSuperRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberPuzzleGameSuperRankViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamesuperrankview.prefab"
	}
end

function NumberPuzzleGameSuperRankViewPresentor:buildViews()
	return {
		NumberPuzzleGameSuperRankView.New()
	}
end

return NumberPuzzleGameSuperRankViewPresentor
