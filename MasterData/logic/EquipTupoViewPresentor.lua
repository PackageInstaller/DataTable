-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipTupoViewPresentor.lua

module("logic.extensions.equipment.view.EquipTupoViewPresentor", package.seeall)

local EquipTupoViewPresentor = class("EquipTupoViewPresentor", ViewPresentor)

function EquipTupoViewPresentor:ctor()
	EquipTupoViewPresentor.super.ctor(self)
end

function EquipTupoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EquipTupoViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/equiptupoview.prefab"
	}
end

function EquipTupoViewPresentor:buildViews()
	return {
		EquipTupoView.New()
	}
end

function EquipTupoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EquipTupoViewPresentor
