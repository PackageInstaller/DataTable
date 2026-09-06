-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkmissionViewPresentor.lua

module("logic.extensions.pk.view.PkmissionViewPresentor", package.seeall)

local PkmissionViewPresentor = class("PkmissionViewPresentor", MissionViewPresentor)

function PkmissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PkmissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/pk/pkmissionview.prefab",
		"ui/views/pk/pkbattleresultview.prefab",
		self:_addCommonRes()
	}
end

function PkmissionViewPresentor:buildViews()
	return {
		PkmissionView.New(),
		FormationRightView.New(),
		PkMissionLeftView.New(),
		PkmissionFmtView.New()
	}
end

return PkmissionViewPresentor
