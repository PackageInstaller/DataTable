-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower3v3MissionViewPresentor.lua

module("logic.extensions.mangtower.view.MangTower3v3MissionViewPresentor", package.seeall)

local MangTower3v3MissionViewPresentor = class("MangTower3v3MissionViewPresentor", MissionViewPresentor)

function MangTower3v3MissionViewPresentor:buildViews()
	return {
		MangTower3v3MissionView.New(),
		MangTower3v3FmtRightView.New(),
		MangTower3v3FmtLeftView.New(),
		MangTower3v3MissionFmtView.New(),
		MangTowerFormTabView.New()
	}
end

return MangTower3v3MissionViewPresentor
