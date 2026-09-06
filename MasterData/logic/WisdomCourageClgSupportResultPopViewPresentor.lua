-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgSupportResultPopViewPresentor.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgSupportResultPopViewPresentor", package.seeall)

local WisdomCourageClgSupportResultPopViewPresentor = class("WisdomCourageClgSupportResultPopViewPresentor", ViewPresentor)

function WisdomCourageClgSupportResultPopViewPresentor:ctor()
	WisdomCourageClgSupportResultPopViewPresentor.super.ctor(self)
end

function WisdomCourageClgSupportResultPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WisdomCourageClgSupportResultPopViewPresentor:dependWhatResources()
	return {
		"ui/views/wisdomcourageclg/wisdomcourageclgsupportresultpopview.prefab"
	}
end

function WisdomCourageClgSupportResultPopViewPresentor:buildViews()
	return {
		WisdomCourageClgSupportResultPopView.New()
	}
end

return WisdomCourageClgSupportResultPopViewPresentor
