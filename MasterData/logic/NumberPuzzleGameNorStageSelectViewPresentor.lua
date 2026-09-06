-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameNorStageSelectViewPresentor.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameNorStageSelectViewPresentor", package.seeall)

local NumberPuzzleGameNorStageSelectViewPresentor = class("NumberPuzzleGameNorStageSelectViewPresentor", ViewPresentor)

function NumberPuzzleGameNorStageSelectViewPresentor:ctor()
	NumberPuzzleGameNorStageSelectViewPresentor.super.ctor(self)
end

function NumberPuzzleGameNorStageSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NumberPuzzleGameNorStageSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/numberpuzzlegame/numberpuzzlegamenorstageselectview.prefab"
	}
end

function NumberPuzzleGameNorStageSelectViewPresentor:buildViews()
	return {
		NumberPuzzleGameNorStageSelectView.New()
	}
end

return NumberPuzzleGameNorStageSelectViewPresentor
