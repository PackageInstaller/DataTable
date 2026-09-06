-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonbattlesettlementfailViewPresentor.lua

module("logic.extensions.season.view.SeasonbattlesettlementfailViewPresentor", package.seeall)

local SeasonbattlesettlementfailViewPresentor = class("SeasonbattlesettlementfailViewPresentor", ViewPresentor)

function SeasonbattlesettlementfailViewPresentor:ctor()
	SeasonbattlesettlementfailViewPresentor.super.ctor(self)
end

function SeasonbattlesettlementfailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonbattlesettlementfailViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonbattlesettlementfailview.prefab"
	}
end

function SeasonbattlesettlementfailViewPresentor:buildViews()
	return {
		SeasonbattlesettlementfailView.New()
	}
end

return SeasonbattlesettlementfailViewPresentor
