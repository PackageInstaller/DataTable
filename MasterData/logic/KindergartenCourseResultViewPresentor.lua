-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartenCourseResultViewPresentor.lua

module("logic.extensions.kindergarten.view.KindergartenCourseResultViewPresentor", package.seeall)

local KindergartenCourseResultViewPresentor = class("KindergartenCourseResultViewPresentor", ViewPresentor)

function KindergartenCourseResultViewPresentor:ctor()
	KindergartenCourseResultViewPresentor.super.ctor(self)
end

function KindergartenCourseResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KindergartenCourseResultViewPresentor:dependWhatResources()
	return {
		"ui/views/kindergarten/kindergartencourseresultview.prefab"
	}
end

function KindergartenCourseResultViewPresentor:buildViews()
	return {
		KindergartenCourseResultView.New()
	}
end

return KindergartenCourseResultViewPresentor
