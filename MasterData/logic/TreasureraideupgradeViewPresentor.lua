-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideupgradeViewPresentor.lua

module("logic.extensions.treasureraider.view.TreasureraideupgradeViewPresentor", package.seeall)

local TreasureraideupgradeViewPresentor = class("TreasureraideupgradeViewPresentor", ViewPresentor)

function TreasureraideupgradeViewPresentor:ctor()
	TreasureraideupgradeViewPresentor.super.ctor(self)
end

function TreasureraideupgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TreasureraideupgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/treasureraider/treasureraideupgradeview.prefab"
	}
end

function TreasureraideupgradeViewPresentor:buildViews()
	return {
		TreasureraideupgradeView.New()
	}
end

return TreasureraideupgradeViewPresentor
