-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusbagViewPresentor.lua

module("logic.extensions.stargodplus.view.StargodplusbagViewPresentor", package.seeall)

local StargodplusbagViewPresentor = class("StargodplusbagViewPresentor", ViewWithGuidePresentor)

function StargodplusbagViewPresentor:ctor()
	StargodplusbagViewPresentor.super.ctor(self)
end

function StargodplusbagViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StargodplusbagViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplus/stargodplusbagview.prefab"
	}
end

function StargodplusbagViewPresentor:buildViews()
	return {
		StargodplusbagView.New()
	}
end

return StargodplusbagViewPresentor
