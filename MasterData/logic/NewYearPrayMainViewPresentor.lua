-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayMainViewPresentor.lua

module("logic.extensions.newyearpray.view.NewYearPrayMainViewPresentor", package.seeall)

local NewYearPrayMainViewPresentor = class("NewYearPrayMainViewPresentor", ViewPresentor)

function NewYearPrayMainViewPresentor:ctor()
	NewYearPrayMainViewPresentor.super.ctor(self)
end

function NewYearPrayMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearPrayMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearpray/newyearpraymainview.prefab"
	}
end

function NewYearPrayMainViewPresentor:buildViews()
	return {
		NewYearPrayMainView.New()
	}
end

return NewYearPrayMainViewPresentor
