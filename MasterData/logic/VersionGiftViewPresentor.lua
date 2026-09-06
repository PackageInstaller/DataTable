-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/versiongift/VersionGiftViewPresentor.lua

module("logic.extensions.bonus.view.versiongift.VersionGiftViewPresentor", package.seeall)

local VersionGiftViewPresentor = class("VersionGiftViewPresentor", ViewPresentor)

function VersionGiftViewPresentor:ctor()
	VersionGiftViewPresentor.super.ctor(self)
end

function VersionGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VersionGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/versiongift/versiongiftview.prefab"
	}
end

function VersionGiftViewPresentor:buildViews()
	return {
		VersionGiftView.New()
	}
end

return VersionGiftViewPresentor
