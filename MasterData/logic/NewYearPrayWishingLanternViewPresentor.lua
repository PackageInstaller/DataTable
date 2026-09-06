-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayWishingLanternViewPresentor.lua

module("logic.extensions.newyearpray.view.NewYearPrayWishingLanternViewPresentor", package.seeall)

local NewYearPrayWishingLanternViewPresentor = class("NewYearPrayWishingLanternViewPresentor", ViewPresentor)

function NewYearPrayWishingLanternViewPresentor:ctor()
	NewYearPrayWishingLanternViewPresentor.super.ctor(self)
end

function NewYearPrayWishingLanternViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearPrayWishingLanternViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearpray/newyearpraywishinglanternview.prefab"
	}
end

function NewYearPrayWishingLanternViewPresentor:buildViews()
	return {
		NewYearPrayWishingLanternView.New()
	}
end

return NewYearPrayWishingLanternViewPresentor
