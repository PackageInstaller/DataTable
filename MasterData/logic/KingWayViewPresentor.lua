-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingWayViewPresentor.lua

module("logic.extensions.kingway.view.KingWayViewPresentor", package.seeall)

local KingWayViewPresentor = class("KingWayViewPresentor", ViewWithGuidePresentor)

function KingWayViewPresentor:ctor()
	KingWayViewPresentor.super.ctor(self)
end

function KingWayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingWayViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/kingwayview.prefab"
	}
end

function KingWayViewPresentor:buildViews()
	return {
		KingWayView.New()
	}
end

return KingWayViewPresentor
