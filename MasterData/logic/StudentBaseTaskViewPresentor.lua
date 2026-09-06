-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/studenttask/StudentBaseTaskViewPresentor.lua

module("logic.extensions.tutorsystem.view.studenttask.StudentBaseTaskViewPresentor", package.seeall)

local StudentBaseTaskViewPresentor = class("StudentBaseTaskViewPresentor", ViewPresentor)

function StudentBaseTaskViewPresentor:ctor()
	StudentBaseTaskViewPresentor.super.ctor(self)
end

function StudentBaseTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StudentBaseTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/studentbasetaskview.prefab"
	}
end

function StudentBaseTaskViewPresentor:buildViews()
	return {
		StudentBaseTaskView.New()
	}
end

function StudentBaseTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StudentBaseTaskViewPresentor
