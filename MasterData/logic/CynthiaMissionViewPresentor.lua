-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/mission/CynthiaMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.mission.CynthiaMissionViewPresentor", package.seeall)

local CynthiaMissionViewPresentor = class("CynthiaMissionViewPresentor", MissionViewPresentor)

function CynthiaMissionViewPresentor:buildViews()
	return {
		CynthiaMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		CynthiaMissionFmtView.New()
	}
end

return CynthiaMissionViewPresentor
