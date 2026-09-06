-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipListViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipListViewPresentor", package.seeall)

local PetEquipListViewPresentor = class("PetEquipListViewPresentor", ViewWithGuidePresentor)

function PetEquipListViewPresentor:ctor()
	PetEquipListViewPresentor.super.ctor(self)
end

function PetEquipListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEquipListViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequiplistview.prefab"
	}
end

function PetEquipListViewPresentor:buildViews()
	return {
		PetEquipListView.New()
	}
end

return PetEquipListViewPresentor
