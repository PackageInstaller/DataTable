-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonstorygridshowViewPresentor.lua

module("logic.extensions.season.view.SeasonstorygridshowViewPresentor", package.seeall)

local SeasonstorygridshowViewPresentor = class("SeasonstorygridshowViewPresentor", ViewPresentor)

function SeasonstorygridshowViewPresentor:ctor()
	SeasonstorygridshowViewPresentor.super.ctor(self)
end

function SeasonstorygridshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonstorygridshowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonstorygridshowview.prefab"
	}
end

function SeasonstorygridshowViewPresentor:buildViews()
	return {
		SeasonStoryGridShowView.New()
	}
end

return SeasonstorygridshowViewPresentor
