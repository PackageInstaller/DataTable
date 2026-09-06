-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectingSkinItemFashionTabFrameViewPresentor.lua

module("logic.extensions.collectingskin.view.CollectingSkinItemFashionTabFrameViewPresentor", package.seeall)

local CollectingSkinItemFashionTabFrameViewPresentor = class("CollectingSkinItemFashionTabFrameViewPresentor", ViewPresentor)

function CollectingSkinItemFashionTabFrameViewPresentor:ctor()
	CollectingSkinItemFashionTabFrameViewPresentor.super.ctor(self)
end

function CollectingSkinItemFashionTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingSkinItemFashionTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingskin/collectingskinitemtabframeview.prefab"
	}
end

function CollectingSkinItemFashionTabFrameViewPresentor:buildViews()
	return {
		CollectingSkinItemFashionTabFrameView.New()
	}
end

return CollectingSkinItemFashionTabFrameViewPresentor
