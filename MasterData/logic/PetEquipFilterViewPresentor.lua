-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipFilterViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipFilterViewPresentor", package.seeall)

local PetEquipFilterViewPresentor = class("PetEquipFilterViewPresentor", ViewPresentor)

function PetEquipFilterViewPresentor:ctor()
	PetEquipFilterViewPresentor.super.ctor(self)
end

function PetEquipFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetEquipFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequipfilterview.prefab"
	}
end

function PetEquipFilterViewPresentor:buildViews()
	return {
		PetEquipFilterView.New()
	}
end

function PetEquipFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetEquipFilterViewPresentor
