-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipBagPetListViewPresentor.lua

module("logic.extensions.equipment.view.EquipBagPetListViewPresentor", package.seeall)

local EquipBagPetListViewPresentor = class("EquipBagPetListViewPresentor", ViewPresentor)

function EquipBagPetListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipBagPetListViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipbagpetlistview.prefab"
	}
end

function EquipBagPetListViewPresentor:buildViews()
	return {
		EquipBagPetListView.New()
	}
end

return EquipBagPetListViewPresentor
