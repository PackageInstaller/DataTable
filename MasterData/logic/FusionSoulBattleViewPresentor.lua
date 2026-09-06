-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulBattleViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulBattleViewPresentor", package.seeall)

local FusionSoulBattleViewPresentor = class("FusionSoulBattleViewPresentor", ViewPresentor)

function FusionSoulBattleViewPresentor:ctor()
	FusionSoulBattleViewPresentor.super.ctor(self)
end

function FusionSoulBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FusionSoulBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulbattleview.prefab"
	}
end

function FusionSoulBattleViewPresentor:buildViews()
	return {
		FusionSoulBattleView.New()
	}
end

return FusionSoulBattleViewPresentor
