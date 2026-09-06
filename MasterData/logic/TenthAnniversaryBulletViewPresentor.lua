-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarypreheat/view/TenthAnniversaryBulletViewPresentor.lua

module("logic.extensions.anniversarypreheat.view.TenthAnniversaryBulletViewPresentor", package.seeall)

local TenthAnniversaryBulletViewPresentor = class("TenthAnniversaryBulletViewPresentor", ViewPresentor)

function TenthAnniversaryBulletViewPresentor:ctor()
	TenthAnniversaryBulletViewPresentor.super.ctor(self)
end

function TenthAnniversaryBulletViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TenthAnniversaryBulletViewPresentor:dependWhatResources()
	return {
		"ui/views/tenthanniversary/tenthanniversarybulletview.prefab"
	}
end

function TenthAnniversaryBulletViewPresentor:buildViews()
	return {
		TenthAnniversaryBulletView.New()
	}
end

return TenthAnniversaryBulletViewPresentor
