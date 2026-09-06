-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasontrainingcourseViewPresentor.lua

module("logic.extensions.season.view.SeasontrainingcourseViewPresentor", package.seeall)

local SeasontrainingcourseViewPresentor = class("SeasontrainingcourseViewPresentor", ViewPresentor)

function SeasontrainingcourseViewPresentor:ctor()
	SeasontrainingcourseViewPresentor.super.ctor(self)
end

function SeasontrainingcourseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasontrainingcourseViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontrainingcourseview.prefab"
	}
end

function SeasontrainingcourseViewPresentor:buildViews()
	return {
		SeasontrainingcourseView.New()
	}
end

return SeasontrainingcourseViewPresentor
