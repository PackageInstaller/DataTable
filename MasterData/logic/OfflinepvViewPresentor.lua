-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinepvViewPresentor.lua

module("logic.extensions.offline.view.OfflinepvViewPresentor", package.seeall)

local OfflinepvViewPresentor = class("OfflinepvViewPresentor", ViewPresentor)

function OfflinepvViewPresentor:ctor()
	OfflinepvViewPresentor.super.ctor(self)
end

function OfflinepvViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OfflinepvViewPresentor:dependWhatResources()
	return {
		"ui/views/offline/offlinepvview.prefab"
	}
end

function OfflinepvViewPresentor:buildViews()
	return {
		OfflinepvView.New()
	}
end

return OfflinepvViewPresentor
