-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/EquipBreakthroughViewPresentor.lua

module("logic.extensions.starequipment.view.EquipBreakthroughViewPresentor", package.seeall)

local EquipBreakthroughViewPresentor = class("EquipBreakthroughViewPresentor", ViewPresentor)

function EquipBreakthroughViewPresentor:ctor()
	EquipBreakthroughViewPresentor.super.ctor(self)
end

function EquipBreakthroughViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipBreakthroughViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/equipbreakthroughview.prefab"
	}
end

function EquipBreakthroughViewPresentor:buildViews()
	return {
		EquipBreakthroughView.New()
	}
end

return EquipBreakthroughViewPresentor
