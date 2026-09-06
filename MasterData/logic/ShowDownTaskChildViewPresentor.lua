-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/showdown/ShowDownTaskChildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.dragonpsychicclg.ShowDownTaskChildViewPresentor", package.seeall)

local ShowDownTaskChildViewPresentor = class("ShowDownTaskChildViewPresentor", ViewPresentor)

function ShowDownTaskChildViewPresentor:ctor()
	ShowDownTaskChildViewPresentor.super.ctor(self)
end

function ShowDownTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/showdown/showdowntaskchildview.prefab"
	}
end

function ShowDownTaskChildViewPresentor:buildViews()
	return {
		ShowDownTaskChildView.New()
	}
end

function ShowDownTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShowDownTaskChildViewPresentor
