-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/studenttask/StudentGrowthTaskViewPresentor.lua

module("logic.extensions.tutorsystem.view.studenttask.StudentGrowthTaskViewPresentor", package.seeall)

local StudentGrowthTaskViewPresentor = class("StudentGrowthTaskViewPresentor", ViewPresentor)

function StudentGrowthTaskViewPresentor:ctor()
	StudentGrowthTaskViewPresentor.super.ctor(self)
end

function StudentGrowthTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StudentGrowthTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/studentbasetaskview.prefab"
	}
end

function StudentGrowthTaskViewPresentor:buildViews()
	return {
		StudentGrowthTaskView.New()
	}
end

function StudentGrowthTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StudentGrowthTaskViewPresentor
