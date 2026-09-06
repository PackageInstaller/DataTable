-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/studenttask/StudentFloorViewPresentor.lua

module("logic.extensions.tutorsystem.view.studenttask.StudentFloorViewPresentor", package.seeall)

local StudentFloorViewPresentor = class("StudentFloorViewPresentor", ViewPresentor)

function StudentFloorViewPresentor:ctor()
	StudentFloorViewPresentor.super.ctor(self)
end

function StudentFloorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StudentFloorViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/studentfloorview.prefab"
	}
end

function StudentFloorViewPresentor:buildViews()
	return {
		StudentFloorView.New()
	}
end

return StudentFloorViewPresentor
