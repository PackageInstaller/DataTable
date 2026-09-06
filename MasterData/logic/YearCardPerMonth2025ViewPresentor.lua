-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardPerMonth2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardPerMonth2025ViewPresentor", package.seeall)

local YearCardPerMonth2025ViewPresentor = class("YearCardPerMonth2025ViewPresentor", ViewPresentor)

function YearCardPerMonth2025ViewPresentor:ctor()
	YearCardPerMonth2025ViewPresentor.super.ctor(self)
end

function YearCardPerMonth2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerMonth2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardpermonth2025view.prefab"
	}
end

function YearCardPerMonth2025ViewPresentor:buildViews()
	return {
		YearCardPerMonth2025View.New()
	}
end

return YearCardPerMonth2025ViewPresentor
