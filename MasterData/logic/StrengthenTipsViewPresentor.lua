-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/StrengthenTipsViewPresentor.lua

module("logic.extensions.equipment.view.StrengthenTipsViewPresentor", package.seeall)

local StrengthenTipsViewPresentor = class("StrengthenTipsViewPresentor", ViewPresentor)

function StrengthenTipsViewPresentor:ctor()
	StrengthenTipsViewPresentor.super.ctor(self)
end

function StrengthenTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StrengthenTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/strengthentipsview.prefab"
	}
end

function StrengthenTipsViewPresentor:buildViews()
	return {
		StrengthenTipsView.New()
	}
end

return StrengthenTipsViewPresentor
