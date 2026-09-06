-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonpaintViewPresentor.lua

module("logic.extensions.season.view.SeasonpaintViewPresentor", package.seeall)

local SeasonpaintViewPresentor = class("SeasonpaintViewPresentor", ViewPresentor)

function SeasonpaintViewPresentor:ctor()
	SeasonpaintViewPresentor.super.ctor(self)
end

function SeasonpaintViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonpaintViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpaintview.prefab"
	}
end

function SeasonpaintViewPresentor:buildViews()
	return {
		SeasonPaintView.New()
	}
end

return SeasonpaintViewPresentor
