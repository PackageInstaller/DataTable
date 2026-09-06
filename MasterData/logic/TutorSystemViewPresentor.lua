-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/tutorsystem/TutorSystemViewPresentor.lua

module("logic.extensions.bonus.view.tutorsystem.TutorSystemViewPresentor", package.seeall)

local TutorSystemViewPresentor = class("TutorSystemViewPresentor", ViewPresentor)

function TutorSystemViewPresentor:ctor()
	TutorSystemViewPresentor.super.ctor(self)
end

function TutorSystemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/tutorsystem/tutorsystemview.prefab"
	}
end

function TutorSystemViewPresentor:buildViews()
	return {
		TutorSystemView.New()
	}
end

return TutorSystemViewPresentor
