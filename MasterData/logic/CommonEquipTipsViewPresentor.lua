-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonEquipTipsViewPresentor.lua

module("logic.extensions.common.instruction.view.CommonEquipTipsViewPresentor", package.seeall)

local CommonEquipTipsViewPresentor = class("CommonEquipTipsViewPresentor", ViewPresentor)

function CommonEquipTipsViewPresentor:ctor()
	CommonEquipTipsViewPresentor.super.ctor(self)
end

function CommonEquipTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CommonEquipTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/common/equip_tips.prefab"
	}
end

function CommonEquipTipsViewPresentor:buildViews()
	return {
		CommonEquipTipsView.New()
	}
end

return CommonEquipTipsViewPresentor
