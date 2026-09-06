-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/lease/StudentLeaseViewPresentor.lua

module("logic.extensions.tutorsystem.view.lease.StudentLeaseViewPresentor", package.seeall)

local StudentLeaseViewPresentor = class("StudentLeaseViewPresentor", ViewPresentor)

function StudentLeaseViewPresentor:ctor()
	StudentLeaseViewPresentor.super.ctor(self)
end

function StudentLeaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StudentLeaseViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/studentleaseview.prefab"
	}
end

function StudentLeaseViewPresentor:buildViews()
	return {
		StudentLeaseView.New()
	}
end

return StudentLeaseViewPresentor
