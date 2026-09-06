-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonenterViewPresentor.lua

module("logic.extensions.season.view.SeasonenterViewPresentor", package.seeall)

local SeasonenterViewPresentor = class("SeasonenterViewPresentor", ViewPresentor)

function SeasonenterViewPresentor:ctor()
	SeasonenterViewPresentor.super.ctor(self)
end

function SeasonenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonenterViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonenterview.prefab"
	}
end

function SeasonenterViewPresentor:buildViews()
	return {
		SeasonenterView.New()
	}
end

return SeasonenterViewPresentor
