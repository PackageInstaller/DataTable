-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemStudentZdlPrizeViewPresentor.lua

module("logic.extensions.tutorsystem.view.TutorSystemStudentZdlPrizeViewPresentor", package.seeall)

local TutorSystemStudentZdlPrizeViewPresentor = class("TutorSystemStudentZdlPrizeViewPresentor", ViewPresentor)

function TutorSystemStudentZdlPrizeViewPresentor:ctor()
	TutorSystemStudentZdlPrizeViewPresentor.super.ctor(self)
end

function TutorSystemStudentZdlPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemStudentZdlPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/tutorsystem/tutorsystemstudentzdlprizeview.prefab"
	}
end

function TutorSystemStudentZdlPrizeViewPresentor:buildViews()
	return {
		TutorSystemStudentZdlPrizeView.New()
	}
end

return TutorSystemStudentZdlPrizeViewPresentor
