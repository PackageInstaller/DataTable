-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidedescViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraidedescViewPresentor", package.seeall)

local TreasureraidedescViewPresentor = class("TreasureraidedescViewPresentor", ViewPresentor)

function TreasureraidedescViewPresentor:ctor()
	TreasureraidedescViewPresentor.super.ctor(self)
end

function TreasureraidedescViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraidedescViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraidedescview.prefab"
	}
end

function TreasureraidedescViewPresentor:buildViews()
	return {
		TreasureraidedescView.New()
	}
end

return TreasureraidedescViewPresentor
