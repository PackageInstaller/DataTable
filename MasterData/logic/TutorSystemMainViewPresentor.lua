-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/mainview/TutorSystemMainViewPresentor.lua

module("logic.extensions.tutorsystem.view.mainview.SuppressGameMainViewPresentor", package.seeall)

local SuppressGameMainViewPresentor = class("SuppressGameMainViewPresentor", ViewPresentor)

function SuppressGameMainViewPresentor:ctor()
	SuppressGameMainViewPresentor.super.ctor(self)
end

function SuppressGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SuppressGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/tutorsystemmainview.prefab"
	}
end

function SuppressGameMainViewPresentor:buildViews()
	return {
		TutorSystemMainView.New()
	}
end

return SuppressGameMainViewPresentor
