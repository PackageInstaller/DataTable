-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syyueyingwang/view/HolyMoonKingLevelsViewPresentor.lua

module("logic.extensions.syyueyingwang.view.HolyMoonKingLevelsViewPresentor", package.seeall)

local HolyMoonKingLevelsViewPresentor = class("HolyMoonKingLevelsViewPresentor", ViewPresentor)

function HolyMoonKingLevelsViewPresentor:ctor()
	HolyMoonKingLevelsViewPresentor.super.ctor(self)
end

function HolyMoonKingLevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyMoonKingLevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syyueyingwang/holymoonkinglevelsview.prefab"
	}
end

function HolyMoonKingLevelsViewPresentor:buildViews()
	return {
		HolyMoonKingLevelsView.New()
	}
end

return HolyMoonKingLevelsViewPresentor
