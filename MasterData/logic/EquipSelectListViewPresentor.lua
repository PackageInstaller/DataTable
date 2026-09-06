-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipSelectListViewPresentor.lua

module("logic.extensions.equipment.view.EquipSelectListViewPresentor", package.seeall)

local EquipSelectListViewPresentor = class("EquipSelectListViewPresentor", ViewWithGuidePresentor)

function EquipSelectListViewPresentor:ctor()
	EquipSelectListViewPresentor.super.ctor(self)
end

function EquipSelectListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipSelectListViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipselectlistview.prefab"
	}
end

function EquipSelectListViewPresentor:buildViews()
	return {
		EquipSelectListView.New()
	}
end

function EquipSelectListViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EquipSelectListViewPresentor
