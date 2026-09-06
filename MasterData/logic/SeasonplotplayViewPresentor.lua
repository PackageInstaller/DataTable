-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonplotplayViewPresentor.lua

module("logic.extensions.season.view.SeasonplotplayViewPresentor", package.seeall)

local SeasonplotplayViewPresentor = class("SeasonplotplayViewPresentor", ViewPresentor)

function SeasonplotplayViewPresentor:ctor()
	SeasonplotplayViewPresentor.super.ctor(self)
end

function SeasonplotplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonplotplayViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonplotplayview.prefab"
	}
end

function SeasonplotplayViewPresentor:buildViews()
	return {
		SeasonPlotPlayView.New()
	}
end

return SeasonplotplayViewPresentor
