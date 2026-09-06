-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderdiceViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraiderdiceViewPresentor", package.seeall)

local TreasureraiderdiceViewPresentor = class("TreasureraiderdiceViewPresentor", ViewPresentor)

function TreasureraiderdiceViewPresentor:ctor()
	TreasureraiderdiceViewPresentor.super.ctor(self)
end

function TreasureraiderdiceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraiderdiceViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraiderdiceview.prefab"
	}
end

function TreasureraiderdiceViewPresentor:buildViews()
	return {
		TreasureraiderdiceView.New()
	}
end

return TreasureraiderdiceViewPresentor
