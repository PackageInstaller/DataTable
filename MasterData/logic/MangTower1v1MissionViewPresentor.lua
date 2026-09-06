-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower1v1MissionViewPresentor.lua

module("logic.extensions.mangtower.view.MangTower1v1MissionViewPresentor", package.seeall)

local MangTower1v1MissionViewPresentor = class("MangTower1v1MissionViewPresentor", MissionViewPresentor)

function MangTower1v1MissionViewPresentor:buildViews()
	return {
		MangTower1v1MissionView.New(),
		MangTower1v1FmtRightView.New(),
		MangTower1v1FmtLeftView.New(),
		MangTower1v1MissionFmtView.New()
	}
end

return MangTower1v1MissionViewPresentor
