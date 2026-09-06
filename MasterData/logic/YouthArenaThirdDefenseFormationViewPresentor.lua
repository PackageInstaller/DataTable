-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdDefenseFormationViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdDefenseFormationViewPresentor", package.seeall)

local YouthArenaThirdDefenseFormationViewPresentor = class("YouthArenaThirdDefenseFormationViewPresentor", MissionViewPresentor)

function YouthArenaThirdDefenseFormationViewPresentor:ctor()
	YouthArenaThirdDefenseFormationViewPresentor.super.ctor(self)
end

function YouthArenaThirdDefenseFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdDefenseFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function YouthArenaThirdDefenseFormationViewPresentor:buildViews()
	return {
		CustomFormationView.New(),
		CustomFmtRightView.New(),
		CustomFmtLeftView.New(),
		YouthArenaThirdDefenseFormTabView.New()
	}
end

return YouthArenaThirdDefenseFormationViewPresentor
