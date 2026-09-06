-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflineViewPresentor.lua

module("logic.extensions.offline.view.OfflineViewPresentor", package.seeall)

local OfflineViewPresentor = class("OfflineViewPresentor", ViewPresentor)

function OfflineViewPresentor:ctor()
	OfflineViewPresentor.super.ctor(self)
end

function OfflineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OfflineViewPresentor:dependWhatResources()
	return {
		"ui/views/offline/offlineview.prefab"
	}
end

function OfflineViewPresentor:buildViews()
	return {
		OfflineView.New()
	}
end

return OfflineViewPresentor
