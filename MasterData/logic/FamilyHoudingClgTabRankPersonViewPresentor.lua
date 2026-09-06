-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabRankPersonViewPresentor.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabRankPersonViewPresentor", package.seeall)

local FamilyHoudingClgTabRankPersonViewPresentor = class("FamilyHoudingClgTabRankPersonViewPresentor", ViewPresentor)

function FamilyHoudingClgTabRankPersonViewPresentor:ctor()
	FamilyHoudingClgTabRankPersonViewPresentor.super.ctor(self)
end

function FamilyHoudingClgTabRankPersonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHoudingClgTabRankPersonViewPresentor:dependWhatResources()
	return {
		"ui/views/familyhoundingclg/familyhoudingclgtabrankpersonview.prefab"
	}
end

function FamilyHoudingClgTabRankPersonViewPresentor:buildViews()
	return {
		FamilyHoudingClgTabRankPersonView.New()
	}
end

function FamilyHoudingClgTabRankPersonViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FamilyHoudingClgTabRankPersonViewPresentor
