-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/StuBaseTaskScheduleViewPresentor.lua

module("logic.extensions.tutorsystem.view.teachertask.StuBaseTaskScheduleViewPresentor", package.seeall)

local StuBaseTaskScheduleViewPresentor = class("StuBaseTaskScheduleViewPresentor", ViewPresentor)

function StuBaseTaskScheduleViewPresentor:ctor()
	StuBaseTaskScheduleViewPresentor.super.ctor(self)
end

function StuBaseTaskScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StuBaseTaskScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/stubasetaskscheduleview.prefab"
	}
end

function StuBaseTaskScheduleViewPresentor:buildViews()
	return {
		StuBaseTaskScheduleView.New()
	}
end

function StuBaseTaskScheduleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StuBaseTaskScheduleViewPresentor
