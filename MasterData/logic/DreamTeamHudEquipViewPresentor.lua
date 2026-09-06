-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudEquipViewPresentor.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudEquipViewPresentor", package.seeall)

local DreamTeamHudEquipViewPresentor = class("DreamTeamHudEquipViewPresentor", ViewPresentor)

function DreamTeamHudEquipViewPresentor:ctor()
	DreamTeamHudEquipViewPresentor.super.ctor(self)
end

function DreamTeamHudEquipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamTeamHudEquipViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteamhud/dreamteamhudequipview.prefab"
	}
end

function DreamTeamHudEquipViewPresentor:buildViews()
	return {
		DreamTeamHudEquipView.New()
	}
end

return DreamTeamHudEquipViewPresentor
