-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipViewPresentor", package.seeall)

local PetEquipViewPresentor = class("PetEquipViewPresentor", ViewWithGuidePresentor)

function PetEquipViewPresentor:ctor()
	PetEquipViewPresentor.super.ctor(self)
end

function PetEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequipview.prefab",
		ItemPet.ResPath
	}
end

function PetEquipViewPresentor:buildViews()
	return {
		PetEquipView.New()
	}
end

function PetEquipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetEquipViewPresentor
