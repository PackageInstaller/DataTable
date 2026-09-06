-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipRecycleQualityViewPresentor.lua

module("logic.extensions.equipment.view.EquipRecycleQualityViewPresentor", package.seeall)

local EquipRecycleQualityViewPresentor = class("EquipRecycleQualityViewPresentor", ViewWithGuidePresentor)

function EquipRecycleQualityViewPresentor:ctor()
	EquipRecycleQualityViewPresentor.super.ctor(self)
end

function EquipRecycleQualityViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipRecycleQualityViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equiprecyclequalityview.prefab"
	}
end

function EquipRecycleQualityViewPresentor:buildViews()
	return {
		EquipRecycleQualityView.New()
	}
end

return EquipRecycleQualityViewPresentor
