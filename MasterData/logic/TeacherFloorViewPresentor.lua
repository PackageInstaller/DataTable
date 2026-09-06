-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/TeacherFloorViewPresentor.lua

module("logic.extensions.tutorsystem.view.teachertask.TeacherFloorViewPresentor", package.seeall)

local TeacherFloorViewPresentor = class("TeacherFloorViewPresentor", ViewPresentor)

function TeacherFloorViewPresentor:ctor()
	TeacherFloorViewPresentor.super.ctor(self)
end

function TeacherFloorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeacherFloorViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/teacherfloorview.prefab"
	}
end

function TeacherFloorViewPresentor:buildViews()
	return {
		TeacherFloorView.New()
	}
end

return TeacherFloorViewPresentor
