-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WaterdraktowermainViewPresentor.lua

module("logic.extensions.waterdraktower.view.WaterdraktowermainViewPresentor", package.seeall)

local WaterdraktowermainViewPresentor = class("WaterdraktowermainViewPresentor", ViewPresentor)

function WaterdraktowermainViewPresentor:ctor()
	WaterdraktowermainViewPresentor.super.ctor(self)
end

function WaterdraktowermainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WaterdraktowermainViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/waterdraktowermainview.prefab"
	}
end

function WaterdraktowermainViewPresentor:buildViews()
	return {
		WaterdraktowermainView.New()
	}
end

return WaterdraktowermainViewPresentor
