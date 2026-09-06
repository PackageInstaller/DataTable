-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonholystripeViewPresentor.lua

module("logic.extensions.season.view.SeasonholystripeViewPresentor", package.seeall)

local SeasonholystripeViewPresentor = class("SeasonholystripeViewPresentor", ViewPresentor)

function SeasonholystripeViewPresentor:ctor()
	SeasonholystripeViewPresentor.super.ctor(self)
end

function SeasonholystripeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonholystripeViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonholystripeview.prefab"
	}
end

function SeasonholystripeViewPresentor:buildViews()
	return {
		SeasonholystripeView.New()
	}
end

return SeasonholystripeViewPresentor
