-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityMainViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityMainViewPresentor", package.seeall)

local GuardCityMainViewPresentor = class("GuardCityMainViewPresentor", ViewPresentor)

function GuardCityMainViewPresentor:ctor()
	GuardCityMainViewPresentor.super.ctor(self)
end

function GuardCityMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcitymainview.prefab"
	}
end

function GuardCityMainViewPresentor:buildViews()
	return {
		GuardCityMainView.New()
	}
end

function GuardCityMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityMainViewPresentor
