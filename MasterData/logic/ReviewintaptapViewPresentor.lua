-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/ReviewintaptapViewPresentor.lua

module("logic.extensions.tips.view.ReviewintaptapViewPresentor", package.seeall)

local ReviewintaptapViewPresentor = class("ReviewintaptapViewPresentor", ViewPresentor)

function ReviewintaptapViewPresentor:ctor()
	ReviewintaptapViewPresentor.super.ctor(self)
end

function ReviewintaptapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReviewintaptapViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/reviewintaptapview.prefab"
	}
end

function ReviewintaptapViewPresentor:buildViews()
	return {
		ReviewintaptapView.New()
	}
end

return ReviewintaptapViewPresentor
