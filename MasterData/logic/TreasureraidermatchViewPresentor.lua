-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidermatchViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraidermatchViewPresentor", package.seeall)

local TreasureraidermatchViewPresentor = class("TreasureraidermatchViewPresentor", ViewPresentor)

function TreasureraidermatchViewPresentor:ctor()
	TreasureraidermatchViewPresentor.super.ctor(self)
end

function TreasureraidermatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraidermatchViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraidermatchview.prefab"
	}
end

function TreasureraidermatchViewPresentor:buildViews()
	return {
		TreasureraidermatchView.New()
	}
end

return TreasureraidermatchViewPresentor
