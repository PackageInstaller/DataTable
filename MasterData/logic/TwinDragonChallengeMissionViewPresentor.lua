-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwinDragonChallengeMissionViewPresentor.lua

module("logic.extensions.twindragonchallenge.view.TwinDragonChallengeMissionViewPresentor", package.seeall)

local TwinDragonChallengeMissionViewPresentor = class("TwinDragonChallengeMissionViewPresentor", MissionViewPresentor)

function TwinDragonChallengeMissionViewPresentor:buildViews()
	return {
		TwinDragonChallengeMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		TwinDragonChallengeMissionFmtView.New()
	}
end

return TwinDragonChallengeMissionViewPresentor
