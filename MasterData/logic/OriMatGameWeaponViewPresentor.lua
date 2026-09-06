-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponViewPresentor", package.seeall)

local OriMatGameWeaponViewPresentor = class("OriMatGameWeaponViewPresentor", ViewPresentor)

function OriMatGameWeaponViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriMatGameWeaponViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameweaponview.prefab"
	}
end

function OriMatGameWeaponViewPresentor:buildViews()
	return {
		OriMatGameWeaponView.New()
	}
end

return OriMatGameWeaponViewPresentor
