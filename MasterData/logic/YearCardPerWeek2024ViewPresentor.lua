-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardPerWeek2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardPerWeek2024ViewPresentor", package.seeall)

local YearCardPerWeek2024ViewPresentor = class("YearCardPerWeek2024ViewPresentor", ViewPresentor)

function YearCardPerWeek2024ViewPresentor:ctor()
	YearCardPerWeek2024ViewPresentor.super.ctor(self)
end

function YearCardPerWeek2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerWeek2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardperweek2024view.prefab"
	}
end

function YearCardPerWeek2024ViewPresentor:buildViews()
	return {
		YearCardPerWeek2024View.New()
	}
end

return YearCardPerWeek2024ViewPresentor
