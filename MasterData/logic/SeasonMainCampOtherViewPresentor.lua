-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMainCampOtherViewPresentor.lua

module("logic.extensions.season.view.SeasonMainCampOtherViewPresentor", package.seeall)

local SeasonMainCampOtherViewPresentor = class("SeasonMainCampOtherViewPresentor", ViewWithGuidePresentor)

function SeasonMainCampOtherViewPresentor:ctor()
	SeasonMainCampOtherViewPresentor.super.ctor(self)
end

function SeasonMainCampOtherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonMainCampOtherViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonmaincampotherview.prefab"
	}
end

function SeasonMainCampOtherViewPresentor:buildViews()
	return {
		SeasonMainCampOtherView.New()
	}
end

return SeasonMainCampOtherViewPresentor
