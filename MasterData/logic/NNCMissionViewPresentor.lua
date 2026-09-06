-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCMissionViewPresentor.lua

module("logic.extensions.niannianchall.view.NNCMissionViewPresentor", package.seeall)

local NNCMissionViewPresentor = class("NNCMissionViewPresentor", MissionViewPresentor)

function NNCMissionViewPresentor:buildViews()
	return {
		NNCMissionView.New(),
		NNCFmtRightView.New(),
		NNCFmtLeftView.New(),
		NNCMissionFmtView.New()
	}
end

return NNCMissionViewPresentor
