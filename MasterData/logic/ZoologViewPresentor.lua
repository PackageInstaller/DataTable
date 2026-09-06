-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoologViewPresentor.lua

module("logic.extensions.zoo.view.ZoologViewPresentor", package.seeall)

local ZoologViewPresentor = class("ZoologViewPresentor", ViewPresentor)

function ZoologViewPresentor:ctor()
	ZoologViewPresentor.super.ctor(self)
end

function ZoologViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoologViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoologview.prefab"
	}
end

function ZoologViewPresentor:buildViews()
	return {
		ZooLogView.New()
	}
end

return ZoologViewPresentor
