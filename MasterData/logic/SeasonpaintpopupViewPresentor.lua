-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonpaintpopupViewPresentor.lua

module("logic.extensions.season.view.SeasonpaintpopupViewPresentor", package.seeall)

local SeasonpaintpopupViewPresentor = class("SeasonpaintpopupViewPresentor", ViewPresentor)

function SeasonpaintpopupViewPresentor:ctor()
	SeasonpaintpopupViewPresentor.super.ctor(self)
end

function SeasonpaintpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonpaintpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpaintpopupview.prefab"
	}
end

function SeasonpaintpopupViewPresentor:buildViews()
	return {
		SeasonpaintpopupView.New()
	}
end

return SeasonpaintpopupViewPresentor
