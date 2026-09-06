-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSuperBuffViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSuperBuffViewPresentor", package.seeall)

local NumberPuzzleGameSuperBuffViewPresentor = class("NumberPuzzleGameSuperBuffViewPresentor", ViewPresentor)

function NumberPuzzleGameSuperBuffViewPresentor:ctor()
	NumberPuzzleGameSuperBuffViewPresentor.super.ctor(self)
end

function NumberPuzzleGameSuperBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NumberPuzzleGameSuperBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamesuperbuffview.prefab"
	}
end

function NumberPuzzleGameSuperBuffViewPresentor:buildViews()
	return {
		NumberPuzzleGameSuperBuffView.New()
	}
end

function NumberPuzzleGameSuperBuffViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NumberPuzzleGameSuperBuffViewPresentor
