-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tutor/TeacherGradAwardTaskViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tutor.TeacherGradAwardTaskViewPresentor", package.seeall)

local TeacherGradAwardTaskViewPresentor = class("TeacherGradAwardTaskViewPresentor", ViewPresentor)

function TeacherGradAwardTaskViewPresentor:ctor()
	TeacherGradAwardTaskViewPresentor.super.ctor(self)
end

function TeacherGradAwardTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TeacherGradAwardTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/teachergradawardtaskview.prefab"
	}
end

function TeacherGradAwardTaskViewPresentor:buildViews()
	return {
		TeacherGradAwardTaskView.New()
	}
end

function TeacherGradAwardTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TeacherGradAwardTaskViewPresentor
