-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotUpgradeViewPresentor.lua

module("logic.extensions.defendcarrot.view.DefendCarrotUpgradeViewPresentor", package.seeall)

local DefendCarrotUpgradeViewPresentor = class("DefendCarrotUpgradeViewPresentor", ViewPresentor)

function DefendCarrotUpgradeViewPresentor:ctor()
	DefendCarrotUpgradeViewPresentor.super.ctor(self)
end

function DefendCarrotUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DefendCarrotUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/defendcarrot/defendcarrotupgradeview.prefab"
	}
end

function DefendCarrotUpgradeViewPresentor:buildViews()
	return {
		DefendCarrotUpgradeView.New()
	}
end

return DefendCarrotUpgradeViewPresentor
