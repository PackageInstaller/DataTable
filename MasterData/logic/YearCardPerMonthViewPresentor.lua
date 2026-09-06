-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardPerMonthViewPresentor.lua

module("logic.extensions.yearcard.view.YearCardPerMonthViewPresentor", package.seeall)

local YearCardPerMonthViewPresentor = class("YearCardPerMonthViewPresentor", ViewPresentor)

function YearCardPerMonthViewPresentor:ctor()
	YearCardPerMonthViewPresentor.super.ctor(self)
end

function YearCardPerMonthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerMonthViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard/yearcardpermonth.prefab"
	}
end

function YearCardPerMonthViewPresentor:buildViews()
	return {
		YearCardPerMonthView.New()
	}
end

function YearCardPerMonthViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YearCardPerMonthViewPresentor
