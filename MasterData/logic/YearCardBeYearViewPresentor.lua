-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardBeYearViewPresentor.lua

module("logic.extensions.yearcard.view.YearCardBeYearViewPresentor", package.seeall)

local YearCardBeYearViewPresentor = class("YearCardBeYearViewPresentor", ViewPresentor)

function YearCardBeYearViewPresentor:ctor()
	YearCardBeYearViewPresentor.super.ctor(self)
end

function YearCardBeYearViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardBeYearViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard/yearcardbeyear.prefab"
	}
end

function YearCardBeYearViewPresentor:buildViews()
	return {
		YearCardBeYearView.New()
	}
end

function YearCardBeYearViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YearCardBeYearViewPresentor
