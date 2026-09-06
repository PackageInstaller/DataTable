-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipTupoOneKeyConfirmViewPresentor.lua

module("logic.extensions.equipment.view.EquipTupoOneKeyConfirmViewPresentor", package.seeall)

local EquipTupoOneKeyConfirmViewPresentor = class("EquipTupoOneKeyConfirmViewPresentor", ViewPresentor)

function EquipTupoOneKeyConfirmViewPresentor:ctor()
	EquipTupoOneKeyConfirmViewPresentor.super.ctor(self)
end

function EquipTupoOneKeyConfirmViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipTupoOneKeyConfirmViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equiptupoonekeyconfirmview.prefab"
	}
end

function EquipTupoOneKeyConfirmViewPresentor:buildViews()
	return {
		EquipTupoOneKeyConfirmView.New()
	}
end

return EquipTupoOneKeyConfirmViewPresentor
