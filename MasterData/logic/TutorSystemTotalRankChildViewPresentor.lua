-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/tutorsystem/TutorSystemTotalRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.tutorsystem.TutorSystemTotalRankChildViewPresentor", package.seeall)

local TutorSystemTotalRankChildViewPresentor = class("TutorSystemTotalRankChildViewPresentor", ViewPresentor)

function TutorSystemTotalRankChildViewPresentor:ctor()
	TutorSystemTotalRankChildViewPresentor.super.ctor(self)
end

function TutorSystemTotalRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TutorSystemTotalRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/tutorsystemtotalrankchildview.prefab"
	}
end

function TutorSystemTotalRankChildViewPresentor:buildViews()
	return {
		TutorSystemTotalRankChildView.New()
	}
end

function TutorSystemTotalRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TutorSystemTotalRankChildViewPresentor
