-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPerMonth2022ViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardPerMonth2022ViewPresentor", package.seeall)

local YearCardPerMonth2022ViewPresentor = class("YearCardPerMonth2022ViewPresentor", ViewPresentor)

function YearCardPerMonth2022ViewPresentor:ctor()
	YearCardPerMonth2022ViewPresentor.super.ctor(self)
end

function YearCardPerMonth2022ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerMonth2022ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/ycpermonth2022view.prefab"
	}
end

function YearCardPerMonth2022ViewPresentor:buildViews()
	return {
		YearCardPerMonth2022View.New()
	}
end

return YearCardPerMonth2022ViewPresentor
