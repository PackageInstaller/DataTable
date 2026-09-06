-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipStrengthenViewPresentor.lua

module("logic.extensions.equipment.view.EquipStrengthenViewPresentor", package.seeall)

local EquipStrengthenViewPresentor = class("EquipStrengthenViewPresentor", ViewWithGuidePresentor)

function EquipStrengthenViewPresentor:ctor()
	EquipStrengthenViewPresentor.super.ctor(self)
end

function EquipStrengthenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipStrengthenViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipstrengthenview.prefab"
	}
end

function EquipStrengthenViewPresentor:buildViews()
	return {
		EquipStrengthenView.New()
	}
end

function EquipStrengthenViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EquipStrengthenViewPresentor
