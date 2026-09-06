-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameMainViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameMainViewPresentor", package.seeall)

local NumberPuzzleGameMainViewPresentor = class("NumberPuzzleGameMainViewPresentor", ViewPresentor)

function NumberPuzzleGameMainViewPresentor:ctor()
	NumberPuzzleGameMainViewPresentor.super.ctor(self)
end

function NumberPuzzleGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberPuzzleGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamemainview.prefab"
	}
end

function NumberPuzzleGameMainViewPresentor:buildViews()
	return {
		NumberPuzzleGameMainView.New()
	}
end

return NumberPuzzleGameMainViewPresentor
