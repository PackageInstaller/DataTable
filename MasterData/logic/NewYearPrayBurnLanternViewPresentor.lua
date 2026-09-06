-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayBurnLanternViewPresentor.lua

module("logic.extensions.newyearpray.view.NewYearPrayBurnLanternViewPresentor", package.seeall)

local NewYearPrayBurnLanternViewPresentor = class("NewYearPrayBurnLanternViewPresentor", ViewPresentor)

function NewYearPrayBurnLanternViewPresentor:ctor()
	NewYearPrayBurnLanternViewPresentor.super.ctor(self)
end

function NewYearPrayBurnLanternViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearPrayBurnLanternViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearpray/newyearprayburnlanternview.prefab"
	}
end

function NewYearPrayBurnLanternViewPresentor:buildViews()
	return {
		NewYearPrayBurnLanternView.New()
	}
end

return NewYearPrayBurnLanternViewPresentor
