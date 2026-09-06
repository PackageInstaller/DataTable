-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/wisdomcourageclg/WisdomCourageClgBossViewRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.wisdomcourageclg.WisdomCourageClgBossViewRankChildViewPresentor", package.seeall)

local WisdomCourageClgBossViewRankChildViewPresentor = class("WisdomCourageClgBossViewRankChildViewPresentor", ViewPresentor)

function WisdomCourageClgBossViewRankChildViewPresentor:ctor()
	WisdomCourageClgBossViewRankChildViewPresentor.super.ctor(self)
end

function WisdomCourageClgBossViewRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WisdomCourageClgBossViewRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/wisdomcourageclgbossviewrankchildview.prefab"
	}
end

function WisdomCourageClgBossViewRankChildViewPresentor:buildViews()
	return {
		WisdomCourageClgBossViewRankChildView.New()
	}
end

function WisdomCourageClgBossViewRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WisdomCourageClgBossViewRankChildViewPresentor
