-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgSupportViewPresentor.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgSupportViewPresentor", package.seeall)

local WisdomCourageClgSupportViewPresentor = class("WisdomCourageClgSupportViewPresentor", ViewPresentor)

function WisdomCourageClgSupportViewPresentor:ctor()
	WisdomCourageClgSupportViewPresentor.super.ctor(self)
end

function WisdomCourageClgSupportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WisdomCourageClgSupportViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomcourageclg/wisdomcourageclgsupportview.prefab"
	}
end

function WisdomCourageClgSupportViewPresentor:buildViews()
	return {
		WisdomCourageClgSupportView.New()
	}
end

function WisdomCourageClgSupportViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return WisdomCourageClgSupportViewPresentor
