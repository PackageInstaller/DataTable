-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipRecycleViewPresentor.lua

module("logic.extensions.equipment.view.EquipRecycleViewPresentor", package.seeall)

local EquipRecycleViewPresentor = class("EquipRecycleViewPresentor", ViewWithGuidePresentor)

function EquipRecycleViewPresentor:ctor()
	EquipRecycleViewPresentor.super.ctor(self)
end

function EquipRecycleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipRecycleViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equiprecycleview.prefab"
	}
end

function EquipRecycleViewPresentor:buildViews()
	return {
		EquipRecycleView.New()
	}
end

return EquipRecycleViewPresentor
