-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardPerMonth2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardPerMonth2026ViewPresentor", package.seeall)

local YearCardPerMonth2026ViewPresentor = class("YearCardPerMonth2026ViewPresentor", ViewPresentor)

function YearCardPerMonth2026ViewPresentor:ctor()
	YearCardPerMonth2026ViewPresentor.super.ctor(self)
end

function YearCardPerMonth2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerMonth2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardpermonth2026view.prefab"
	}
end

function YearCardPerMonth2026ViewPresentor:buildViews()
	return {
		YearCardPerMonth2026View.New()
	}
end

return YearCardPerMonth2026ViewPresentor
