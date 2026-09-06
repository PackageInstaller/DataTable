-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFactorySifterViewPresentor.lua

module("logic.extensions.equipment.view.EquipFactorySifterViewPresentor", package.seeall)

local EquipFactorySifterViewPresentor = class("EquipFactorySifterViewPresentor", ViewWithGuidePresentor)

function EquipFactorySifterViewPresentor:ctor()
	EquipFactorySifterViewPresentor.super.ctor(self)
end

function EquipFactorySifterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EquipFactorySifterViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipfactorysifterview.prefab"
	}
end

function EquipFactorySifterViewPresentor:buildViews()
	return {
		EquipFactorySifterView.New()
	}
end

return EquipFactorySifterViewPresentor
