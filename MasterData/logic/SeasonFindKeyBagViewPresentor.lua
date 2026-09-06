-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFindKeyBagViewPresentor.lua

module("logic.extensions.season.view.SeasonFindKeyBagViewPresentor", package.seeall)

local SeasonFindKeyBagViewPresentor = class("SeasonFindKeyBagViewPresentor", ViewPresentor)

function SeasonFindKeyBagViewPresentor:ctor()
	SeasonFindKeyBagViewPresentor.super.ctor(self)
end

function SeasonFindKeyBagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonFindKeyBagViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonfindkeybagview.prefab"
	}
end

function SeasonFindKeyBagViewPresentor:buildViews()
	return {
		SeasonFindKeyBagView.New()
	}
end

return SeasonFindKeyBagViewPresentor
