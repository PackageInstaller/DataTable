-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/lease/TeacherLeaseViewPresentor.lua

module("logic.extensions.tutorsystem.view.lease.TeacherLeaseViewPresentor", package.seeall)

local TeacherLeaseViewPresentor = class("TeacherLeaseViewPresentor", ViewPresentor)

function TeacherLeaseViewPresentor:ctor()
	TeacherLeaseViewPresentor.super.ctor(self)
end

function TeacherLeaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeacherLeaseViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/teacherleaseview.prefab"
	}
end

function TeacherLeaseViewPresentor:buildViews()
	return {
		TeacherLeaseView.New()
	}
end

return TeacherLeaseViewPresentor
