-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardPerWeek2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardPerWeek2023ViewPresentor", package.seeall)

local YearCardPerWeek2023ViewPresentor = class("YearCardPerWeek2023ViewPresentor", ViewPresentor)

function YearCardPerWeek2023ViewPresentor:ctor()
	YearCardPerWeek2023ViewPresentor.super.ctor(self)
end

function YearCardPerWeek2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerWeek2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardperweek2023view.prefab"
	}
end

function YearCardPerWeek2023ViewPresentor:buildViews()
	return {
		YearCardPerWeek2023View.New()
	}
end

return YearCardPerWeek2023ViewPresentor
