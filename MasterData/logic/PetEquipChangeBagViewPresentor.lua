-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipChangeBagViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipChangeBagViewPresentor", package.seeall)

local PetEquipChangeBagViewPresentor = class("PetEquipChangeBagViewPresentor", ViewWithGuidePresentor)

function PetEquipChangeBagViewPresentor:ctor()
	PetEquipChangeBagViewPresentor.super.ctor(self)
end

function PetEquipChangeBagViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEquipChangeBagViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequipchangebagview.prefab",
		ItemPet.ResPath
	}
end

function PetEquipChangeBagViewPresentor:buildViews()
	return {
		PetEquipChangeBagView.New()
	}
end

function PetEquipChangeBagViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetEquipChangeBagViewPresentor
