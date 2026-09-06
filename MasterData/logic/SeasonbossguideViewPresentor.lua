-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonbossguideViewPresentor.lua

module("logic.extensions.season.view.SeasonbossguideViewPresentor", package.seeall)

local SeasonbossguideViewPresentor = class("SeasonbossguideViewPresentor", ViewPresentor)

function SeasonbossguideViewPresentor:ctor()
	SeasonbossguideViewPresentor.super.ctor(self)
end

function SeasonbossguideViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeasonbossguideViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonbossguideview.prefab"
	}
end

function SeasonbossguideViewPresentor:buildViews()
	return {
		SeasonbossguideView.New()
	}
end

return SeasonbossguideViewPresentor
