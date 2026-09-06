-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearCollectSelectViewPresentor.lua

module("logic.extensions.birthdaywishes.view.NewYearCollectSelectViewPresentor", package.seeall)

local NewYearCollectSelectViewPresentor = class("NewYearCollectSelectViewPresentor", ViewPresentor)

function NewYearCollectSelectViewPresentor:ctor()
	NewYearCollectSelectViewPresentor.super.ctor(self)
end

function NewYearCollectSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearCollectSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearcollectword/newyearcollectselectview.prefab"
	}
end

function NewYearCollectSelectViewPresentor:buildViews()
	return {
		NewYearCollectSelectView.New()
	}
end

return NewYearCollectSelectViewPresentor
