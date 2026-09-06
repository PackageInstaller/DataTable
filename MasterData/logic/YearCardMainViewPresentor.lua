-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardMainViewPresentor.lua

module("logic.extensions.yearcard.view.YearCardMainViewPresentor", package.seeall)

local YearCardMainViewPresentor = class("YearCardMainViewPresentor", ViewPresentor)

function YearCardMainViewPresentor:ctor()
	YearCardMainViewPresentor.super.ctor(self)
end

function YearCardMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard/yearcardmainview.prefab"
	}
end

function YearCardMainViewPresentor:buildViews()
	return {
		YearCardMainView.New()
	}
end

function YearCardMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YearCardMainViewPresentor
