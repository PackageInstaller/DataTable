-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSuperMainViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSuperMainViewPresentor", package.seeall)

local NumberPuzzleGameSuperMainViewPresentor = class("NumberPuzzleGameSuperMainViewPresentor", ViewPresentor)

function NumberPuzzleGameSuperMainViewPresentor:ctor()
	NumberPuzzleGameSuperMainViewPresentor.super.ctor(self)
end

function NumberPuzzleGameSuperMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberPuzzleGameSuperMainViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamesupermainview.prefab"
	}
end

function NumberPuzzleGameSuperMainViewPresentor:buildViews()
	return {
		NumberPuzzleGameSuperMainView.New()
	}
end

return NumberPuzzleGameSuperMainViewPresentor
