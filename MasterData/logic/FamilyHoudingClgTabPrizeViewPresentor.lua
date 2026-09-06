-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabPrizeViewPresentor.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabPrizeViewPresentor", package.seeall)

local FamilyHoudingClgTabPrizeViewPresentor = class("FamilyHoudingClgTabPrizeViewPresentor", ViewPresentor)

function FamilyHoudingClgTabPrizeViewPresentor:ctor()
	FamilyHoudingClgTabPrizeViewPresentor.super.ctor(self)
end

function FamilyHoudingClgTabPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHoudingClgTabPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/familyhoundingclg/familyhoudingclgtabprizeview.prefab"
	}
end

function FamilyHoudingClgTabPrizeViewPresentor:buildViews()
	return {
		FamilyHoudingClgTabPrizeView.New()
	}
end

function FamilyHoudingClgTabPrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilyHoudingClgTabPrizeViewPresentor
