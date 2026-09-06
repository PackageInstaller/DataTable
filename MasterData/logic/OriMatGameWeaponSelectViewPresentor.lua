-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponSelectViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponSelectViewPresentor", package.seeall)

local OriMatGameWeaponSelectViewPresentor = class("OriMatGameWeaponSelectViewPresentor", ViewPresentor)

function OriMatGameWeaponSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriMatGameWeaponSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameweaponselectview.prefab"
	}
end

function OriMatGameWeaponSelectViewPresentor:buildViews()
	return {
		OriMatGameWeaponSelectView.New()
	}
end

return OriMatGameWeaponSelectViewPresentor
