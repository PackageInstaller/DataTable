-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardPerMonth2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardPerMonth2024ViewPresentor", package.seeall)

local YearCardPerMonth2024ViewPresentor = class("YearCardPerMonth2024ViewPresentor", ViewPresentor)

function YearCardPerMonth2024ViewPresentor:ctor()
	YearCardPerMonth2024ViewPresentor.super.ctor(self)
end

function YearCardPerMonth2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerMonth2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardpermonth2024view.prefab"
	}
end

function YearCardPerMonth2024ViewPresentor:buildViews()
	return {
		YearCardPerMonth2024View.New()
	}
end

return YearCardPerMonth2024ViewPresentor
