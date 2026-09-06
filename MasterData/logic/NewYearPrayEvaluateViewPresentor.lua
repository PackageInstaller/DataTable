-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayEvaluateViewPresentor.lua

module("logic.extensions.newyearpray.view.NewYearPrayEvaluateViewPresentor", package.seeall)

local NewYearPrayEvaluateViewPresentor = class("NewYearPrayEvaluateViewPresentor", ViewPresentor)

function NewYearPrayEvaluateViewPresentor:ctor()
	NewYearPrayEvaluateViewPresentor.super.ctor(self)
end

function NewYearPrayEvaluateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearPrayEvaluateViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearpray/newyearprayevaluateview.prefab"
	}
end

function NewYearPrayEvaluateViewPresentor:buildViews()
	return {
		NewYearPrayEvaluateView.New()
	}
end

return NewYearPrayEvaluateViewPresentor
