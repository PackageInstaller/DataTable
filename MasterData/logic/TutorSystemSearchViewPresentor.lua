-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemSearchViewPresentor.lua

module("logic.extensions.tutorsystem.view.TutorSystemSearchViewPresentor", package.seeall)

local TutorSystemSearchViewPresentor = class("TutorSystemSearchViewPresentor", ViewPresentor)

function TutorSystemSearchViewPresentor:ctor()
	TutorSystemSearchViewPresentor.super.ctor(self)
end

function TutorSystemSearchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemSearchViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/tutorsystemsearchview.prefab"
	}
end

function TutorSystemSearchViewPresentor:buildViews()
	return {
		TutorSystemSearchView.New()
	}
end

return TutorSystemSearchViewPresentor
