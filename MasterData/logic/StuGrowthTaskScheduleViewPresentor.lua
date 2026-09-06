-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/StuGrowthTaskScheduleViewPresentor.lua

module("logic.extensions.tutorsystem.view.teachertask.StuGrowthTaskScheduleViewPresentor", package.seeall)

local StuGrowthTaskScheduleViewPresentor = class("StuGrowthTaskScheduleViewPresentor", ViewPresentor)

function StuGrowthTaskScheduleViewPresentor:ctor()
	StuGrowthTaskScheduleViewPresentor.super.ctor(self)
end

function StuGrowthTaskScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StuGrowthTaskScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/studentbasetaskview.prefab"
	}
end

function StuGrowthTaskScheduleViewPresentor:buildViews()
	return {
		StuGrowthTaskScheduleView.New()
	}
end

function StuGrowthTaskScheduleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StuGrowthTaskScheduleViewPresentor
