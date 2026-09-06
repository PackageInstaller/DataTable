-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/view/HeadsetViewPresentor.lua

module("logic.extensions.headitem.view.HeadsetViewPresentor", package.seeall)

local HeadsetViewPresentor = class("HeadsetViewPresentor", ViewPresentor)

function HeadsetViewPresentor:ctor()
	HeadsetViewPresentor.super.ctor(self)
end

function HeadsetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeadsetViewPresentor:dependWhatResources()
	return {
		"ui/views/headitem/headsetview.prefab"
	}
end

function HeadsetViewPresentor:buildViews()
	return {
		HeadsetView.New()
	}
end

return HeadsetViewPresentor
