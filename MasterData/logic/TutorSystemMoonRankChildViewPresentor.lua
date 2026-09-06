-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/tutorsystem/TutorSystemMoonRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.tutorsystem.TutorSystemMoonRankChildViewPresentor", package.seeall)

local TutorSystemMoonRankChildViewPresentor = class("TutorSystemMoonRankChildViewPresentor", ViewPresentor)

function TutorSystemMoonRankChildViewPresentor:ctor()
	TutorSystemMoonRankChildViewPresentor.super.ctor(self)
end

function TutorSystemMoonRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemMoonRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/tutorsystemmoonrankchildview.prefab"
	}
end

function TutorSystemMoonRankChildViewPresentor:buildViews()
	return {
		TutorSystemMoonRankChildView.New()
	}
end

function TutorSystemMoonRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TutorSystemMoonRankChildViewPresentor
