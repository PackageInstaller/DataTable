-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemTabFrameViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemTabFrameViewPresentor", package.seeall)

local CollectingSkinItemTabFrameViewPresentor = class("CollectingSkinItemTabFrameViewPresentor", ViewPresentor)

function CollectingSkinItemTabFrameViewPresentor:ctor()
	CollectingSkinItemTabFrameViewPresentor.super.ctor(self)
end

function CollectingSkinItemTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingSkinItemTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectingskinitemtabframeview.prefab"
	}
end

function CollectingSkinItemTabFrameViewPresentor:buildViews()
	return {
		CollectingSkinItemTabFrameView.New()
	}
end

return CollectingSkinItemTabFrameViewPresentor
