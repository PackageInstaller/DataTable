-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponUpgradeDescTipsViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponUpgradeDescTipsViewPresentor", package.seeall)

local OriMatGameWeaponUpgradeDescTipsViewPresentor = class("OriMatGameWeaponUpgradeDescTipsViewPresentor", ViewPresentor)

function OriMatGameWeaponUpgradeDescTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriMatGameWeaponUpgradeDescTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameweaponupgradedesctipsview.prefab"
	}
end

function OriMatGameWeaponUpgradeDescTipsViewPresentor:buildViews()
	return {
		OriMatGameWeaponUpgradeDescTipsView.New()
	}
end

return OriMatGameWeaponUpgradeDescTipsViewPresentor
