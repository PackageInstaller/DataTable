-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFilterViewPresentor.lua

module("logic.extensions.equipment.view.EquipFilterViewPresentor", package.seeall)

local EquipFilterViewPresentor = class("EquipFilterViewPresentor", ViewPresentor)

function EquipFilterViewPresentor:ctor()
	EquipFilterViewPresentor.super.ctor(self)
end

function EquipFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function EquipFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipfilterview.prefab"
	}
end

function EquipFilterViewPresentor:buildViews()
	return {
		EquipFilterView.New()
	}
end

return EquipFilterViewPresentor
