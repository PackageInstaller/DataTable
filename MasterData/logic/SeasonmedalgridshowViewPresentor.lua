-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonmedalgridshowViewPresentor.lua

module("logic.extensions.season.view.SeasonmedalgridshowViewPresentor", package.seeall)

local SeasonmedalgridshowViewPresentor = class("SeasonmedalgridshowViewPresentor", ViewPresentor)

function SeasonmedalgridshowViewPresentor:ctor()
	SeasonmedalgridshowViewPresentor.super.ctor(self)
end

function SeasonmedalgridshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonmedalgridshowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonmedalgridshowview.prefab"
	}
end

function SeasonmedalgridshowViewPresentor:buildViews()
	return {
		SeasonMedalGridShowView.New()
	}
end

return SeasonmedalgridshowViewPresentor
