-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/view/TaskcardhotViewPresentor.lua

module("logic.extensions.cardhot.view.TaskcardhotViewPresentor", package.seeall)

local TaskcardhotViewPresentor = class("TaskcardhotViewPresentor", ViewPresentor)

function TaskcardhotViewPresentor:ctor()
	TaskcardhotViewPresentor.super.ctor(self)
end

function TaskcardhotViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TaskcardhotViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/cardhot/taskcardhotview.prefab"
	}
end

function TaskcardhotViewPresentor:buildViews()
	return {
		TaskcardhotView.New()
	}
end

return TaskcardhotViewPresentor
