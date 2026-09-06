-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/NewYearWordTabViewPresentor.lua

module("logic.extensions.partysummary.view.NewYearWordTabViewPresentor", package.seeall)

local NewYearWordTabViewPresentor = class("NewYearWordTabViewPresentor", ViewPresentor)

function NewYearWordTabViewPresentor:ctor()
	NewYearWordTabViewPresentor.super.ctor(self)
end

function NewYearWordTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearWordTabViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearword/newyearwordtabview.prefab"
	}
end

function NewYearWordTabViewPresentor:buildViews()
	return {
		NewYearWordTabView.New()
	}
end

return NewYearWordTabViewPresentor
