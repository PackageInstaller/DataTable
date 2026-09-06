-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialEquipViewPresentor.lua

module("logic.extensions.villaintrial.view.VillaintrialEquipViewPresentor", package.seeall)

local VillaintrialEquipViewPresentor = class("VillaintrialEquipViewPresentor", ViewPresentor)

function VillaintrialEquipViewPresentor:ctor()
	VillaintrialEquipViewPresentor.super.ctor(self)
end

function VillaintrialEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VillaintrialEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/villaintrial/villaintrialequipview.prefab"
	}
end

function VillaintrialEquipViewPresentor:buildViews()
	return {
		VillaintrialEquipView.New()
	}
end

return VillaintrialEquipViewPresentor
