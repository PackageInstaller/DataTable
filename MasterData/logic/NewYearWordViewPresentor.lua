-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/NewYearWordViewPresentor.lua

module("logic.extensions.partysummary.view.NewYearWordViewPresentor", package.seeall)

local NewYearWordViewPresentor = class("NewYearWordViewPresentor", ViewPresentor)

function NewYearWordViewPresentor:ctor()
	NewYearWordViewPresentor.super.ctor(self)
end

function NewYearWordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearWordViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearword/newyearwordview.prefab"
	}
end

function NewYearWordViewPresentor:buildViews()
	return {
		NewYearWordView.New()
	}
end

function NewYearWordViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NewYearWordViewPresentor
