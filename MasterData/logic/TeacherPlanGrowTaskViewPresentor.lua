-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/TeacherPlanGrowTaskViewPresentor.lua

module("logic.extensions.tutorsystem.view.teachertask.TeacherPlanGrowTaskViewPresentor", package.seeall)

local TeacherPlanGrowTaskViewPresentor = class("TeacherPlanGrowTaskViewPresentor", ViewPresentor)

function TeacherPlanGrowTaskViewPresentor:ctor()
	TeacherPlanGrowTaskViewPresentor.super.ctor(self)
end

function TeacherPlanGrowTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeacherPlanGrowTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/teacherplangrowtaskview.prefab"
	}
end

function TeacherPlanGrowTaskViewPresentor:buildViews()
	return {
		TeacherPlanGrowTaskView.New()
	}
end

return TeacherPlanGrowTaskViewPresentor
