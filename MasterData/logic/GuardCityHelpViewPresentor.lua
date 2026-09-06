-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityHelpViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityHelpViewPresentor", package.seeall)

local GuardCityHelpViewPresentor = class("GuardCityHelpViewPresentor", ViewPresentor)

function GuardCityHelpViewPresentor:ctor()
	GuardCityHelpViewPresentor.super.ctor(self)
end

function GuardCityHelpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityHelpViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityhelpview.prefab"
	}
end

function GuardCityHelpViewPresentor:buildViews()
	return {
		GuardCityHelpView.New()
	}
end

function GuardCityHelpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityHelpViewPresentor
