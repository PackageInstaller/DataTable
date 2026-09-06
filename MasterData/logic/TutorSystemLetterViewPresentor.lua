-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemLetterViewPresentor.lua

module("logic.extensions.tutorsystem.view.TutorSystemLetterViewPresentor", package.seeall)

local TutorSystemLetterViewPresentor = class("TutorSystemLetterViewPresentor", ViewPresentor)

function TutorSystemLetterViewPresentor:ctor()
	TutorSystemLetterViewPresentor.super.ctor(self)
end

function TutorSystemLetterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemLetterViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/tutorsystemletterview.prefab"
	}
end

function TutorSystemLetterViewPresentor:buildViews()
	return {
		TutorSystemLetterView.New()
	}
end

return TutorSystemLetterViewPresentor
