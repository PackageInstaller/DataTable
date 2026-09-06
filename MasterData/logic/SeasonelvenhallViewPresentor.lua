-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonelvenhallViewPresentor.lua

module("logic.extensions.season.view.SeasonelvenhallViewPresentor", package.seeall)

local SeasonelvenhallViewPresentor = class("SeasonelvenhallViewPresentor", ViewPresentor)

function SeasonelvenhallViewPresentor:ctor()
	SeasonelvenhallViewPresentor.super.ctor(self)
end

function SeasonelvenhallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonelvenhallViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonelvenhallview.prefab"
	}
end

function SeasonelvenhallViewPresentor:buildViews()
	return {
		SeasonelvenhallView.New()
	}
end

return SeasonelvenhallViewPresentor
