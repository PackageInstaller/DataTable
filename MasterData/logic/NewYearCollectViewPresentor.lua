-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearCollectViewPresentor.lua

module("logic.extensions.birthdaywishes.view.NewYearCollectViewPresentor", package.seeall)

local NewYearCollectViewPresentor = class("NewYearCollectViewPresentor", ViewPresentor)

function NewYearCollectViewPresentor:ctor()
	NewYearCollectViewPresentor.super.ctor(self)
end

function NewYearCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearcollectword/newyearcollectview.prefab"
	}
end

function NewYearCollectViewPresentor:buildViews()
	return {
		NewYearCollectView.New()
	}
end

return NewYearCollectViewPresentor
