-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRankViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityRankViewPresentor", package.seeall)

local GuardCityRankViewPresentor = class("GuardCityRankViewPresentor", ViewPresentor)

function GuardCityRankViewPresentor:ctor()
	GuardCityRankViewPresentor.super.ctor(self)
end

function GuardCityRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityRankViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityrankview.prefab"
	}
end

function GuardCityRankViewPresentor:buildViews()
	return {
		GuardCityRankView.New()
	}
end

function GuardCityRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityRankViewPresentor
