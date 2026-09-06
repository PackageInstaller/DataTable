-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRankViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRankViewPresentor", package.seeall)

local GoddessCompetitionRankViewPresentor = class("GoddessCompetitionRankViewPresentor", ViewPresentor)

function GoddessCompetitionRankViewPresentor:ctor()
	GoddessCompetitionRankViewPresentor.super.ctor(self)
end

function GoddessCompetitionRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionrankview.prefab"
	}
end

function GoddessCompetitionRankViewPresentor:buildViews()
	return {
		GoddessCompetitionRankView.New()
	}
end

return GoddessCompetitionRankViewPresentor
