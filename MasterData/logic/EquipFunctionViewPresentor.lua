-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFunctionViewPresentor.lua

module("logic.extensions.petequip.view.EquipFunctionViewPresentor", package.seeall)

local EquipFunctionViewPresentor = class("EquipFunctionViewPresentor", ViewPresentor)

EquipFunctionViewPresentor.MateriaListPath = "ui/views/petequip/equipmaterialistview.prefab"

function EquipFunctionViewPresentor:ctor()
	EquipFunctionViewPresentor.super.ctor(self)
end

function EquipFunctionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipFunctionViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipfunctionview.prefab"
	}
end

function EquipFunctionViewPresentor:buildViews()
	return {
		EquipFunctionView.New()
	}
end

return EquipFunctionViewPresentor
