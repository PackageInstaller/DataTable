-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFindKeyGridShowViewPresentor.lua

module("logic.extensions.season.view.SeasonFindKeyGridShowViewPresentor", package.seeall)

local SeasonFindKeyGridShowViewPresentor = class("SeasonFindKeyGridShowViewPresentor", ViewPresentor)

function SeasonFindKeyGridShowViewPresentor:ctor()
	SeasonFindKeyGridShowViewPresentor.super.ctor(self)
end

function SeasonFindKeyGridShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonFindKeyGridShowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonfindkeygridshowview.prefab"
	}
end

function SeasonFindKeyGridShowViewPresentor:buildViews()
	return {
		SeasonFindKeyGridShowView.New()
	}
end

return SeasonFindKeyGridShowViewPresentor
