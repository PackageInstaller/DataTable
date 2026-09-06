-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityScoreDetailViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityScoreDetailViewPresentor", package.seeall)

local GuardCityScoreDetailViewPresentor = class("GuardCityScoreDetailViewPresentor", ViewPresentor)

function GuardCityScoreDetailViewPresentor:ctor()
	GuardCityScoreDetailViewPresentor.super.ctor(self)
end

function GuardCityScoreDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityScoreDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityscoredetailview.prefab"
	}
end

function GuardCityScoreDetailViewPresentor:buildViews()
	return {
		GuardCityScoreDetailView.New()
	}
end

function GuardCityScoreDetailViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityScoreDetailViewPresentor
