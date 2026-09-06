-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipOneKeyFilterViewPresentor.lua

module("logic.extensions.equipment.view.EquipOneKeyFilterViewPresentor", package.seeall)

local EquipOneKeyFilterViewPresentor = class("EquipOneKeyFilterViewPresentor", ViewPresentor)

function EquipOneKeyFilterViewPresentor:ctor()
	EquipOneKeyFilterViewPresentor.super.ctor(self)
end

function EquipOneKeyFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function EquipOneKeyFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equiponekeyfilterview.prefab"
	}
end

function EquipOneKeyFilterViewPresentor:buildViews()
	return {
		EquipOneKeyFilterView.New()
	}
end

function EquipOneKeyFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EquipOneKeyFilterViewPresentor
