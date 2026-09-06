-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortTabViewPresentor.lua

module("logic.extensions.season.view.SeasonPassPortTabViewPresentor", package.seeall)

local SeasonPassPortTabViewPresentor = class("SeasonPassPortTabViewPresentor", ViewPresentor)

function SeasonPassPortTabViewPresentor:ctor()
	SeasonPassPortTabViewPresentor.super.ctor(self)
end

function SeasonPassPortTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonPassPortTabViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpassporttabview.prefab"
	}
end

function SeasonPassPortTabViewPresentor:buildViews()
	return {
		SeasonPassPortTabView.New()
	}
end

return SeasonPassPortTabViewPresentor
