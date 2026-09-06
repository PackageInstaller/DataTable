-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityGameViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityGameViewPresentor", package.seeall)

local GuardCityGameViewPresentor = class("GuardCityGameViewPresentor", ViewPresentor)

function GuardCityGameViewPresentor:ctor()
	GuardCityGameViewPresentor.super.ctor(self)
end

function GuardCityGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityGameViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcitygameview.prefab"
	}
end

function GuardCityGameViewPresentor:buildViews()
	return {
		GuardCityGameView.New()
	}
end

function GuardCityGameViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityGameViewPresentor
