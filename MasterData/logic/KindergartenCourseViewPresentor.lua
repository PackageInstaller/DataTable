-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartenCourseViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartenCourseViewPresentor", package.seeall)

local KindergartenCourseViewPresentor = class("KindergartenCourseViewPresentor", ViewPresentor)

function KindergartenCourseViewPresentor:ctor()
	KindergartenCourseViewPresentor.super.ctor(self)
end

function KindergartenCourseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergartenCourseViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartencourseview.prefab"
	}
end

function KindergartenCourseViewPresentor:buildViews()
	return {
		KindergartenCourseView.New()
	}
end

return KindergartenCourseViewPresentor
