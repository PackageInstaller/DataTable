-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupDailyPrizeViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupDailyPrizeViewPresentor", package.seeall)

local WorldCupDailyPrizeViewPresentor = class("WorldCupDailyPrizeViewPresentor", ViewPresentor)

function WorldCupDailyPrizeViewPresentor:ctor()
	WorldCupDailyPrizeViewPresentor.super.ctor(self)
end

function WorldCupDailyPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WorldCupDailyPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupdailyprizeview.prefab"
	}
end

function WorldCupDailyPrizeViewPresentor:buildViews()
	return {
		WorldCupDailyPrizeView.New()
	}
end

return WorldCupDailyPrizeViewPresentor
