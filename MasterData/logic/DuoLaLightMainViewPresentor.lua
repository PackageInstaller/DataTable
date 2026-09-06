-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/DuoLaLightMainViewPresentor.lua

module("logic.extensions.duolalight.view.DuoLaLightMainViewPresentor", package.seeall)

local DuoLaLightMainViewPresentor = class("DuoLaLightMainViewPresentor", ViewPresentor)

function DuoLaLightMainViewPresentor:ctor()
	DuoLaLightMainViewPresentor.super.ctor(self)
end

function DuoLaLightMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DuoLaLightMainViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/duolalightmainview.prefab"
	}
end

function DuoLaLightMainViewPresentor:buildViews()
	return {
		DuoLaLightMainView.New()
	}
end

return DuoLaLightMainViewPresentor
