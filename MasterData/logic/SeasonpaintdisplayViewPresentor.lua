-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonpaintdisplayViewPresentor.lua

module("logic.extensions.season.view.SeasonpaintdisplayViewPresentor", package.seeall)

local SeasonpaintdisplayViewPresentor = class("SeasonpaintdisplayViewPresentor", ViewPresentor)

function SeasonpaintdisplayViewPresentor:ctor()
	SeasonpaintdisplayViewPresentor.super.ctor(self)
end

function SeasonpaintdisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeasonpaintdisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpaintdisplayview.prefab"
	}
end

function SeasonpaintdisplayViewPresentor:buildViews()
	return {
		SeasonPaintDisplayView.New()
	}
end

return SeasonpaintdisplayViewPresentor
