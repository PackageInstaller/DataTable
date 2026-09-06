-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoofollowViewPresentor.lua

module("logic.extensions.zoo.view.ZoofollowViewPresentor", package.seeall)

local ZoofollowViewPresentor = class("ZoofollowViewPresentor", ViewPresentor)

function ZoofollowViewPresentor:ctor()
	ZoofollowViewPresentor.super.ctor(self)
end

function ZoofollowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoofollowViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoofollowview.prefab"
	}
end

function ZoofollowViewPresentor:buildViews()
	return {
		ZoofollowView.New()
	}
end

return ZoofollowViewPresentor
