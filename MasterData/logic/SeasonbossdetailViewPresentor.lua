-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonbossdetailViewPresentor.lua

module("logic.extensions.season.view.SeasonbossdetailViewPresentor", package.seeall)

local SeasonbossdetailViewPresentor = class("SeasonbossdetailViewPresentor", ViewPresentor)

function SeasonbossdetailViewPresentor:ctor()
	SeasonbossdetailViewPresentor.super.ctor(self)
end

function SeasonbossdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonbossdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonbossdetailview.prefab"
	}
end

function SeasonbossdetailViewPresentor:buildViews()
	return {
		SeasonBossDetailView.New()
	}
end

return SeasonbossdetailViewPresentor
