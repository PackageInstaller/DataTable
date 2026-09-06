-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/view/SystemSettingViewPresentor.lua

module("logic.extensions.systemsetting.view.SystemSettingViewPresentor", package.seeall)

local SystemSettingViewPresentor = class("SystemSettingViewPresentor", ViewPresentor)

function SystemSettingViewPresentor:ctor()
	SystemSettingViewPresentor.super.ctor(self)
end

function SystemSettingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SystemSettingViewPresentor:dependWhatResources()
	return {
		"ui/views/systemsetting/systemsettingview.prefab"
	}
end

function SystemSettingViewPresentor:buildViews()
	return {
		SystemSettingView.New()
	}
end

return SystemSettingViewPresentor
