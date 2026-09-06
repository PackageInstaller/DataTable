-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/view/TenthAnniversaryPreheatViewPresentor.lua

module("logic.extensions.anniversarypreheat.view.TenthAnniversaryPreheatViewPresentor", package.seeall)

local TenthAnniversaryPreheatViewPresentor = class("TenthAnniversaryPreheatViewPresentor", ViewPresentor)

function TenthAnniversaryPreheatViewPresentor:ctor()
	TenthAnniversaryPreheatViewPresentor.super.ctor(self)
end

function TenthAnniversaryPreheatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TenthAnniversaryPreheatViewPresentor:dependWhatResources()
	return {
		"ui/views/tenthanniversary/tenthanniversarypreheatview.prefab"
	}
end

function TenthAnniversaryPreheatViewPresentor:buildViews()
	return {
		TenthAnniversaryPreheatView.New()
	}
end

return TenthAnniversaryPreheatViewPresentor
