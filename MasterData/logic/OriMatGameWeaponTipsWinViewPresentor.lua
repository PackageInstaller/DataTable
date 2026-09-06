-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponTipsWinViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponTipsWinViewPresentor", package.seeall)

local OriMatGameWeaponTipsWinViewPresentor = class("OriMatGameWeaponTipsWinViewPresentor", ViewPresentor)

function OriMatGameWeaponTipsWinViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriMatGameWeaponTipsWinViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameweapontipswinview.prefab"
	}
end

function OriMatGameWeaponTipsWinViewPresentor:buildViews()
	return {
		OriMatGameWeaponTipsWinView.New()
	}
end

return OriMatGameWeaponTipsWinViewPresentor
