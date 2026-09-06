-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameRankViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameRankViewPresentor", package.seeall)

local NumberPuzzleGameRankViewPresentor = class("NumberPuzzleGameRankViewPresentor", ViewPresentor)

function NumberPuzzleGameRankViewPresentor:ctor()
	NumberPuzzleGameRankViewPresentor.super.ctor(self)
end

function NumberPuzzleGameRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberPuzzleGameRankViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamerankview.prefab"
	}
end

function NumberPuzzleGameRankViewPresentor:buildViews()
	return {
		NumberPuzzleGameRankView.New()
	}
end

return NumberPuzzleGameRankViewPresentor
