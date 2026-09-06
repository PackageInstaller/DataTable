-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/FreeZoneViewPresentor.lua

module("logic.extensions.doubleeleven.view.FreeZoneViewPresentor", package.seeall)

local FreeZoneViewPresentor = class("FreeZoneViewPresentor", ViewWithGuidePresentor)

function FreeZoneViewPresentor:ctor()
	FreeZoneViewPresentor.super.ctor(self)
end

function FreeZoneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeZoneViewPresentor:dependWhatResources()
	return {
		"ui/views/doubleeleven/freezoneview.prefab"
	}
end

function FreeZoneViewPresentor:buildViews()
	return {
		FreeZoneView.New()
	}
end

return FreeZoneViewPresentor
