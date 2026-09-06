-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardPresentor2022.lua

module("logic.extensions.monthcard.view.MonthcardPresentor20222022", package.seeall)

local MonthcardPresentor2022 = class("MonthcardPresentor2022", ViewPresentor)

function MonthcardPresentor2022:ctor()
	MonthcardPresentor2022.super.ctor(self)
end

function MonthcardPresentor2022:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MonthcardPresentor2022:dependWhatResources()
	return {
		"ui/views/monthcard/monthcardview2022.prefab"
	}
end

function MonthcardPresentor2022:buildViews()
	return {
		MonthcardView2022.New()
	}
end

function MonthcardPresentor2022:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MonthcardPresentor2022
