-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoofollowsurePresentor.lua

module("logic.extensions.zoo.view.ZoofollowsurePresentor", package.seeall)

local ZoofollowsurePresentor = class("ZoofollowsurePresentor", ViewPresentor)

function ZoofollowsurePresentor:ctor()
	ZoofollowsurePresentor.super.ctor(self)
end

function ZoofollowsurePresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoofollowsurePresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoofollowsureview.prefab"
	}
end

function ZoofollowsurePresentor:buildViews()
	return {
		ZoofollowsureView.New()
	}
end

return ZoofollowsurePresentor
