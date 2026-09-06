-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tutor/TeacherAchvTaskViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tutor.TeacherAchvTaskViewPresentor", package.seeall)

local TeacherAchvTaskViewPresentor = class("TeacherAchvTaskViewPresentor", ViewPresentor)

function TeacherAchvTaskViewPresentor:ctor()
	TeacherAchvTaskViewPresentor.super.ctor(self)
end

function TeacherAchvTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TeacherAchvTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/teacherachvtaskview.prefab"
	}
end

function TeacherAchvTaskViewPresentor:buildViews()
	return {
		TeacherAchvTaskView.New()
	}
end

function TeacherAchvTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TeacherAchvTaskViewPresentor
