-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPerWeek2022ViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardPerWeek2022ViewPresentor", package.seeall)

local YearCardPerWeek2022ViewPresentor = class("YearCardPerWeek2022ViewPresentor", ViewPresentor)

function YearCardPerWeek2022ViewPresentor:ctor()
	YearCardPerWeek2022ViewPresentor.super.ctor(self)
end

function YearCardPerWeek2022ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerWeek2022ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/ycperweek2022view.prefab"
	}
end

function YearCardPerWeek2022ViewPresentor:buildViews()
	return {
		YearCardPerWeek2022View.New()
	}
end

return YearCardPerWeek2022ViewPresentor
