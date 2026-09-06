-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/view/TaskcardhotshareViewPresentor.lua

module("logic.extensions.cardhot.view.TaskcardhotshareViewPresentor", package.seeall)

local TaskcardhotshareViewPresentor = class("TaskcardhotshareViewPresentor", ViewPresentor)

function TaskcardhotshareViewPresentor:ctor()
	TaskcardhotshareViewPresentor.super.ctor(self)
end

function TaskcardhotshareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TaskcardhotshareViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/cardhot/taskcardhotshareview.prefab"
	}
end

function TaskcardhotshareViewPresentor:buildViews()
	return {
		TaskcardhotshareView.New()
	}
end

return TaskcardhotshareViewPresentor
