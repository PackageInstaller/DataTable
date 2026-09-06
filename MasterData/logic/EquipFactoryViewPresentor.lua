-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFactoryViewPresentor.lua

module("logic.extensions.equipment.view.EquipFactoryViewPresentor", package.seeall)

local EquipFactoryViewPresentor = class("EquipFactoryViewPresentor", ViewWithGuidePresentor)

function EquipFactoryViewPresentor:ctor()
	EquipFactoryViewPresentor.super.ctor(self)
end

function EquipFactoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipFactoryViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipfactoryview.prefab"
	}
end

function EquipFactoryViewPresentor:buildViews()
	return {
		EquipFactoryView.New()
	}
end

return EquipFactoryViewPresentor
