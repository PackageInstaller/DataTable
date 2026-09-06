-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/EquipLvUpViewPresentor.lua

module("logic.extensions.starequipment.view.EquipLvUpViewPresentor", package.seeall)

local EquipLvUpViewPresentor = class("EquipLvUpViewPresentor", ViewPresentor)

function EquipLvUpViewPresentor:ctor()
	EquipLvUpViewPresentor.super.ctor(self)
end

function EquipLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/equiplvupview.prefab"
	}
end

function EquipLvUpViewPresentor:buildViews()
	return {
		EquipLvUpView.New()
	}
end

return EquipLvUpViewPresentor
