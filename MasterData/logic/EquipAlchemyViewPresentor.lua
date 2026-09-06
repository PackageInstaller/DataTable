-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipAlchemyViewPresentor.lua

module("logic.extensions.equipment.view.EquipAlchemyViewPresentor", package.seeall)

local EquipAlchemyViewPresentor = class("EquipAlchemyViewPresentor", ViewWithGuidePresentor)

function EquipAlchemyViewPresentor:ctor()
	EquipAlchemyViewPresentor.super.ctor(self)
end

function EquipAlchemyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipAlchemyViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equipalchemyview.prefab"
	}
end

function EquipAlchemyViewPresentor:buildViews()
	return {
		EquipAlchemyView.New()
	}
end

return EquipAlchemyViewPresentor
