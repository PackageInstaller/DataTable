-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgMainViewPresentor.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgMainViewPresentor", package.seeall)

local WisdomCourageClgMainViewPresentor = class("WisdomCourageClgMainViewPresentor", ViewPresentor)

function WisdomCourageClgMainViewPresentor:ctor()
	WisdomCourageClgMainViewPresentor.super.ctor(self)
end

function WisdomCourageClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WisdomCourageClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomcourageclg/wisdomcourageclgmainview.prefab"
	}
end

function WisdomCourageClgMainViewPresentor:buildViews()
	return {
		WisdomCourageClgMainView.New()
	}
end

return WisdomCourageClgMainViewPresentor
