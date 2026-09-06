-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemPuzzleViewPresentor.lua

module("logic.extensions.tutorsystem.view.TutorSystemPuzzleViewPresentor", package.seeall)

local TutorSystemPuzzleViewPresentor = class("TutorSystemPuzzleViewPresentor", ViewPresentor)

function TutorSystemPuzzleViewPresentor:ctor()
	TutorSystemPuzzleViewPresentor.super.ctor(self)
end

function TutorSystemPuzzleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemPuzzleViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/tutorsystempuzzleview.prefab"
	}
end

function TutorSystemPuzzleViewPresentor:buildViews()
	return {
		TutorSystemPuzzleView.New()
	}
end

return TutorSystemPuzzleViewPresentor
