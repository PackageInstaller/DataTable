-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipTupoOneKeyViewPresentor.lua

module("logic.extensions.equipment.view.EquipTupoOneKeyViewPresentor", package.seeall)

local EquipTupoOneKeyViewPresentor = class("EquipTupoOneKeyViewPresentor", ViewWithGuidePresentor)

function EquipTupoOneKeyViewPresentor:ctor()
	EquipTupoOneKeyViewPresentor.super.ctor(self)
end

function EquipTupoOneKeyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipTupoOneKeyViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equiptupoonekeyview.prefab"
	}
end

function EquipTupoOneKeyViewPresentor:buildViews()
	return {
		EquipTupoOneKeyView.New()
	}
end

return EquipTupoOneKeyViewPresentor
