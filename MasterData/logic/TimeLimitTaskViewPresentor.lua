-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/view/TimeLimitTaskViewPresentor.lua

module("logic.extensions.diamondtask.view.TimeLimitTaskViewPresentor", package.seeall)

local TimeLimitTaskViewPresentor = class("TimeLimitTaskViewPresentor", ViewPresentor)

function TimeLimitTaskViewPresentor:ctor()
	TimeLimitTaskViewPresentor.super.ctor(self)
end

function TimeLimitTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimeLimitTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/diamondtask/timelimittaskview.prefab"
	}
end

function TimeLimitTaskViewPresentor:buildViews()
	return {
		TimeLimitTaskView.New()
	}
end

function TimeLimitTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TimeLimitTaskViewPresentor
