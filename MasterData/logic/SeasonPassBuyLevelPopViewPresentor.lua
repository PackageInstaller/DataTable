-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassBuyLevelPopViewPresentor.lua

module("logic.extensions.season.view.SeasonPassBuyLevelPopViewPresentor", package.seeall)

local SeasonPassBuyLevelPopViewPresentor = class("SeasonPassBuyLevelPopViewPresentor", ViewPresentor)

function SeasonPassBuyLevelPopViewPresentor:ctor()
	SeasonPassBuyLevelPopViewPresentor.super.ctor(self)
end

function SeasonPassBuyLevelPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonPassBuyLevelPopViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonbuyporgressview.prefab"
	}
end

function SeasonPassBuyLevelPopViewPresentor:buildViews()
	return {
		SeasonPassBuyLevelPopView.New()
	}
end

return SeasonPassBuyLevelPopViewPresentor
