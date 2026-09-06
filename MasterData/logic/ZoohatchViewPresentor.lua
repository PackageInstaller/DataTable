-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoohatchViewPresentor.lua

module("logic.extensions.zoo.view.ZoohatchViewPresentor", package.seeall)

local ZoohatchViewPresentor = class("ZoohatchViewPresentor", ViewWithGuidePresentor)

function ZoohatchViewPresentor:ctor()
	ZoohatchViewPresentor.super.ctor(self)
end

function ZoohatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoohatchViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoohatchview.prefab"
	}
end

function ZoohatchViewPresentor:buildViews()
	return {
		ZoohatchView.New()
	}
end

return ZoohatchViewPresentor
