-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTotemPoleOtherViewPresentor.lua

module("logic.extensions.season.view.SeasonTotemPoleOtherViewPresentor", package.seeall)

local SeasonTotemPoleOtherViewPresentor = class("SeasonTotemPoleOtherViewPresentor", ViewPresentor)

function SeasonTotemPoleOtherViewPresentor:ctor()
	SeasonTotemPoleOtherViewPresentor.super.ctor(self)
end

function SeasonTotemPoleOtherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonTotemPoleOtherViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontotempoleotherview.prefab"
	}
end

function SeasonTotemPoleOtherViewPresentor:buildViews()
	return {
		SeasonTotemPoleOtherView.New()
	}
end

return SeasonTotemPoleOtherViewPresentor
