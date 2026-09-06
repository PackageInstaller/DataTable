-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardPerMonth2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardPerMonth2023ViewPresentor", package.seeall)

local YearCardPerMonth2023ViewPresentor = class("YearCardPerMonth2023ViewPresentor", ViewPresentor)

function YearCardPerMonth2023ViewPresentor:ctor()
	YearCardPerMonth2023ViewPresentor.super.ctor(self)
end

function YearCardPerMonth2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerMonth2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardpermonth2023view.prefab"
	}
end

function YearCardPerMonth2023ViewPresentor:buildViews()
	return {
		YearCardPerMonth2023View.New()
	}
end

return YearCardPerMonth2023ViewPresentor
