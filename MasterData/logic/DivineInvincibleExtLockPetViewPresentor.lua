-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtLockPetViewPresentor.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtLockPetViewPresentor", package.seeall)

local DivineInvincibleExtLockPetViewPresentor = class("DivineInvincibleExtLockPetViewPresentor", ViewPresentor)

function DivineInvincibleExtLockPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineInvincibleExtLockPetViewPresentor:dependWhatResources()
	return {
		"ui/views/divineinvincible/divineinvincibleextlockpetview.prefab"
	}
end

function DivineInvincibleExtLockPetViewPresentor:buildViews()
	return {
		DivineInvincibleExtLockPetView.New()
	}
end

return DivineInvincibleExtLockPetViewPresentor
