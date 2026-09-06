-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthCardCriticalViewPresentor.lua

module("logic.extensions.monthcard.view.MonthCardCriticalViewPresentor", package.seeall)

local MonthCardCriticalViewPresentor = class("MonthCardCriticalViewPresentor", ViewPresentor)

function MonthCardCriticalViewPresentor:ctor()
	MonthCardCriticalViewPresentor.super.ctor(self)
end

function MonthCardCriticalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonthCardCriticalViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardcriticalview.prefab"
	}
end

function MonthCardCriticalViewPresentor:buildViews()
	return {
		MonthCardCriticalView.New()
	}
end

function MonthCardCriticalViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MonthCardCriticalViewPresentor
