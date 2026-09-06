-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardPresentor.lua

module("logic.extensions.monthcard.view.MonthcardPresentor", package.seeall)

local MonthcardPresentor = class("MonthcardPresentor", ViewPresentor)

function MonthcardPresentor:ctor()
	MonthcardPresentor.super.ctor(self)
end

function MonthcardPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonthcardPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardview.prefab"
	}
end

function MonthcardPresentor:buildViews()
	return {
		MonthcardView.New()
	}
end

function MonthcardPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MonthcardPresentor
