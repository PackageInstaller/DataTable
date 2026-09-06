-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionSettingViewPresentor.lua

module("logic.extensions.mission.view.MissionSettingViewPresentor", package.seeall)

local MissionSettingViewPresentor = class("MissionSettingViewPresentor", ViewPresentor)

function MissionSettingViewPresentor:ctor()
	MissionSettingViewPresentor.super.ctor(self)
end

function MissionSettingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MissionSettingViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionsettingview.prefab"
	}
end

function MissionSettingViewPresentor:buildViews()
	return {
		MissionSettingView.New()
	}
end

return MissionSettingViewPresentor
