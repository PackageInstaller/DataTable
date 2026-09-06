-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/EquipSelectViewPresentor.lua

module("logic.extensions.starequipment.view.EquipSelectViewPresentor", package.seeall)

local EquipSelectViewPresentor = class("EquipSelectViewPresentor", ViewPresentor)

function EquipSelectViewPresentor:ctor()
	EquipSelectViewPresentor.super.ctor(self)
end

function EquipSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/equipselectview.prefab"
	}
end

function EquipSelectViewPresentor:buildViews()
	return {
		EquipSelectView.New()
	}
end

return EquipSelectViewPresentor
