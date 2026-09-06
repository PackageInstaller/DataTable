-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallTaskViewPresentor.lua

module("logic.extensions.recalltask.view.RecallTaskViewPresentor", package.seeall)

local RecallTaskViewPresentor = class("RecallTaskViewPresentor", ViewPresentor)

function RecallTaskViewPresentor:ctor()
	RecallTaskViewPresentor.super.ctor(self)
end

function RecallTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecallTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/recalltask/recalltaskview.prefab"
	}
end

function RecallTaskViewPresentor:buildViews()
	return {
		RecallTaskView.New()
	}
end

return RecallTaskViewPresentor
