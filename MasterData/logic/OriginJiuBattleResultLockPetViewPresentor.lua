-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginJiuBattleResultLockPetViewPresentor.lua

module("logic.extensions.originjiu.view.OriginJiuBattleResultLockPetViewPresentor", package.seeall)

local OriginJiuBattleResultLockPetViewPresentor = class("OriginJiuBattleResultLockPetViewPresentor", ViewPresentor)

function OriginJiuBattleResultLockPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginJiuBattleResultLockPetViewPresentor:dependWhatResources()
	return {
		"ui/views/originjiu/originjiubattleresultlockpetview.prefab"
	}
end

function OriginJiuBattleResultLockPetViewPresentor:buildViews()
	return {
		OriginJiuBattleResultLockPetView.New()
	}
end

return OriginJiuBattleResultLockPetViewPresentor
