-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabRankFamilyViewPresentor.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabRankFamilyViewPresentor", package.seeall)

local FamilyHoudingClgTabRankFamilyViewPresentor = class("FamilyHoudingClgTabRankFamilyViewPresentor", ViewPresentor)

function FamilyHoudingClgTabRankFamilyViewPresentor:ctor()
	FamilyHoudingClgTabRankFamilyViewPresentor.super.ctor(self)
end

function FamilyHoudingClgTabRankFamilyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHoudingClgTabRankFamilyViewPresentor:dependWhatResources()
	return {
		"ui/views/familyhoundingclg/familyhoudingclgtabrankfamilyview.prefab"
	}
end

function FamilyHoudingClgTabRankFamilyViewPresentor:buildViews()
	return {
		FamilyHoudingClgTabRankFamilyView.New()
	}
end

function FamilyHoudingClgTabRankFamilyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilyHoudingClgTabRankFamilyViewPresentor
