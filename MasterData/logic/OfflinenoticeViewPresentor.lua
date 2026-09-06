-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinenoticeViewPresentor.lua

module("logic.extensions.offline.view.OfflinenoticeViewPresentor", package.seeall)

local OfflinenoticeViewPresentor = class("OfflinenoticeViewPresentor", ViewPresentor)

function OfflinenoticeViewPresentor:ctor()
	OfflinenoticeViewPresentor.super.ctor(self)
end

function OfflinenoticeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OfflinenoticeViewPresentor:dependWhatResources()
	return {
		"ui/views/offline/offlinenoticeview.prefab"
	}
end

function OfflinenoticeViewPresentor:buildViews()
	return {
		OfflinenoticeView.New()
	}
end

return OfflinenoticeViewPresentor
