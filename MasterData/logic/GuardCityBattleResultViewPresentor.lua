-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityBattleResultViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityBattleResultViewPresentor", package.seeall)

local GuardCityBattleResultViewPresentor = class("GuardCityBattleResultViewPresentor", ViewPresentor)

function GuardCityBattleResultViewPresentor:ctor()
	GuardCityBattleResultViewPresentor.super.ctor(self)
end

function GuardCityBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcitybattleresultview.prefab"
	}
end

function GuardCityBattleResultViewPresentor:buildViews()
	return {
		GuardCityBattleResultView.New()
	}
end

function GuardCityBattleResultViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityBattleResultViewPresentor
