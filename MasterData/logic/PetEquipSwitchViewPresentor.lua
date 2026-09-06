-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetEquipSwitchViewPresentor.lua

module("logic.extensions.starequipment.view.PetEquipSwitchViewPresentor", package.seeall)

local PetEquipSwitchViewPresentor = class("PetEquipSwitchViewPresentor", ViewPresentor)

function PetEquipSwitchViewPresentor:ctor()
	PetEquipSwitchViewPresentor.super.ctor(self)
end

function PetEquipSwitchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEquipSwitchViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/petequipswitchview.prefab"
	}
end

function PetEquipSwitchViewPresentor:buildViews()
	return {
		PetEquipSwitchView.New()
	}
end

return PetEquipSwitchViewPresentor
