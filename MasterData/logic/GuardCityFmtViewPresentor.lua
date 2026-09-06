-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityFmtViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityFmtViewPresentor", package.seeall)

local GuardCityFmtViewPresentor = class("GuardCityFmtViewPresentor", ViewPresentor)

function GuardCityFmtViewPresentor:ctor()
	GuardCityFmtViewPresentor.super.ctor(self)
end

function GuardCityFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityfmtview.prefab"
	}
end

function GuardCityFmtViewPresentor:buildViews()
	return {
		GuardCityFmtView.New()
	}
end

function GuardCityFmtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function GuardCityFmtViewPresentor:onClickOutside()
	self:close()
end

return GuardCityFmtViewPresentor
