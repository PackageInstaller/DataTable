-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearFlyWishViewPresentor.lua

module("logic.extensions.birthdaywishes.view.NewYearFlyWishViewPresentor", package.seeall)

local NewYearFlyWishViewPresentor = class("NewYearFlyWishViewPresentor", ViewPresentor)

function NewYearFlyWishViewPresentor:ctor()
	NewYearFlyWishViewPresentor.super.ctor(self)
end

function NewYearFlyWishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearFlyWishViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearcollectword/newyearflywishview.prefab"
	}
end

function NewYearFlyWishViewPresentor:buildViews()
	return {
		NewYearFlyWishView.New()
	}
end

return NewYearFlyWishViewPresentor
