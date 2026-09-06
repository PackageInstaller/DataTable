-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/TupoUpgradeViewPresentor.lua

module("logic.extensions.equipment.view.TupoUpgradeViewPresentor", package.seeall)

local TupoUpgradeViewPresentor = class("TupoUpgradeViewPresentor", ViewWithGuidePresentor)

function TupoUpgradeViewPresentor:ctor()
	TupoUpgradeViewPresentor.super.ctor(self)
end

function TupoUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TupoUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/tupoupgradeview.prefab"
	}
end

function TupoUpgradeViewPresentor:buildViews()
	return {
		TupoUpgradeView.New()
	}
end

return TupoUpgradeViewPresentor
