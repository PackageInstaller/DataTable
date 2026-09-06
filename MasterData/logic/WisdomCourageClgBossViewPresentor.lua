-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgBossViewPresentor.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgBossViewPresentor", package.seeall)

local WisdomCourageClgBossViewPresentor = class("WisdomCourageClgBossViewPresentor", ViewPresentor)

function WisdomCourageClgBossViewPresentor:ctor()
	WisdomCourageClgBossViewPresentor.super.ctor(self)
end

function WisdomCourageClgBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WisdomCourageClgBossViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomcourageclg/wisdomcourageclgbossview.prefab"
	}
end

function WisdomCourageClgBossViewPresentor:buildViews()
	return {
		WisdomCourageClgBossView.New()
	}
end

function WisdomCourageClgBossViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WisdomCourageClgBossViewPresentor
