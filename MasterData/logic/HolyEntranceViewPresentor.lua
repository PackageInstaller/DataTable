-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyEntranceViewPresentor.lua

module("logic.extensions.kingway.view.HolyEntranceViewPresentor", package.seeall)

local HolyEntranceViewPresentor = class("HolyEntranceViewPresentor", ViewWithGuidePresentor)

function HolyEntranceViewPresentor:ctor()
	HolyEntranceViewPresentor.super.ctor(self)
end

function HolyEntranceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyEntranceViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/holyentranceview.prefab"
	}
end

function HolyEntranceViewPresentor:buildViews()
	return {
		HolyEntranceView.New()
	}
end

return HolyEntranceViewPresentor
