-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/onepeople/OnePeopleStageViewPresentor.lua

module("logic.extensions.scenariocopy.view.onepeople.OnePeopleStageViewPresentor", package.seeall)

local OnePeopleStageViewPresentor = class("OnePeopleStageViewPresentor", ViewPresentor)

function OnePeopleStageViewPresentor:ctor()
	OnePeopleStageViewPresentor.super.ctor(self)
end

function OnePeopleStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OnePeopleStageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/onepeople/multicopydetailview.prefab"
	}
end

function OnePeopleStageViewPresentor:buildViews()
	return {
		OnePeopleStageView.New()
	}
end

return OnePeopleStageViewPresentor
