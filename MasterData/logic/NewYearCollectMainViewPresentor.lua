-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearCollectMainViewPresentor.lua

module("logic.extensions.birthdaywishes.view.NewYearCollectMainViewPresentor", package.seeall)

local NewYearCollectMainViewPresentor = class("NewYearCollectMainViewPresentor", ViewPresentor)

function NewYearCollectMainViewPresentor:ctor()
	NewYearCollectMainViewPresentor.super.ctor(self)
end

function NewYearCollectMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearCollectMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearcollectword/newyearcollectmainview.prefab"
	}
end

function NewYearCollectMainViewPresentor:buildViews()
	return {
		NewYearCollectMainView.New()
	}
end

return NewYearCollectMainViewPresentor
