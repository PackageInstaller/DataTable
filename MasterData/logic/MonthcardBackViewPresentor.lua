-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardBackViewPresentor.lua

module("logic.extensions.monthcard.view.MonthcardBackViewPresentor", package.seeall)

local MonthcardBackViewPresentor = class("MonthcardBackViewPresentor", ViewPresentor)

function MonthcardBackViewPresentor:ctor()
	MonthcardBackViewPresentor.super.ctor(self)
end

function MonthcardBackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonthcardBackViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardview2022.prefab"
	}
end

function MonthcardBackViewPresentor:buildViews()
	return {
		MonthcardBackView.New()
	}
end

function MonthcardBackViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MonthcardBackViewPresentor
