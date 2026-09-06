-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/LightDarkAngelMainViewPresentor.lua

module("logic.extensions.teshamu.view.LightDarkAngelMainViewPresentor", package.seeall)

local LightDarkAngelMainViewPresentor = class("LightDarkAngelMainViewPresentor", ViewPresentor)

function LightDarkAngelMainViewPresentor:ctor()
	LightDarkAngelMainViewPresentor.super.ctor(self)
end

function LightDarkAngelMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightDarkAngelMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightdarkangel/lightdarkangelmainview.prefab"
	}
end

function LightDarkAngelMainViewPresentor:buildViews()
	return {
		LightDarkAngelMainView.New()
	}
end

return LightDarkAngelMainViewPresentor
