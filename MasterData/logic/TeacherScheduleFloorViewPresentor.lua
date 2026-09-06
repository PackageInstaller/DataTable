-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/teachertask/TeacherScheduleFloorViewPresentor.lua

module("logic.extensions.tutorsystem.view.teachertask.TeacherScheduleFloorViewPresentor", package.seeall)

local TeacherScheduleFloorViewPresentor = class("TeacherScheduleFloorViewPresentor", ViewPresentor)

function TeacherScheduleFloorViewPresentor:ctor()
	TeacherScheduleFloorViewPresentor.super.ctor(self)
end

function TeacherScheduleFloorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeacherScheduleFloorViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/teacherschedulefloorview.prefab"
	}
end

function TeacherScheduleFloorViewPresentor:buildViews()
	return {
		TeacherScheduleFloorView.New()
	}
end

return TeacherScheduleFloorViewPresentor
