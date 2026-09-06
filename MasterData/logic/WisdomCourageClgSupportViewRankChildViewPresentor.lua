-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/wisdomcourageclg/WisdomCourageClgSupportViewRankChildViewPresentor.lua

module("logic.extensions.commontabrank.view.wisdomcourageclg.WisdomCourageClgSupportViewRankChildViewPresentor", package.seeall)

local WisdomCourageClgSupportViewRankChildViewPresentor = class("WisdomCourageClgSupportViewRankChildViewPresentor", ViewPresentor)

function WisdomCourageClgSupportViewRankChildViewPresentor:ctor()
	WisdomCourageClgSupportViewRankChildViewPresentor.super.ctor(self)
end

function WisdomCourageClgSupportViewRankChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WisdomCourageClgSupportViewRankChildViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/wisdomcourageclgsupportviewrankchildview.prefab"
	}
end

function WisdomCourageClgSupportViewRankChildViewPresentor:buildViews()
	return {
		WisdomCourageClgSupportViewRankChildView.New()
	}
end

function WisdomCourageClgSupportViewRankChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WisdomCourageClgSupportViewRankChildViewPresentor
