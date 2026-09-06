-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetEquipLvupViewPresentor.lua

module("logic.extensions.starequipment.view.PetEquipLvupViewPresentor", package.seeall)

local PetEquipLvupViewPresentor = class("PetEquipLvupViewPresentor", ViewPresentor)

function PetEquipLvupViewPresentor:ctor()
	PetEquipLvupViewPresentor.super.ctor(self)
end

function PetEquipLvupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetEquipLvupViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/petequiplvupview.prefab"
	}
end

function PetEquipLvupViewPresentor:buildViews()
	return {
		PetEquipLvupView.New()
	}
end

return PetEquipLvupViewPresentor
