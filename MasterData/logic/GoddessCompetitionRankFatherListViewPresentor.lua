-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/goddesscompetition/GoddessCompetitionRankFatherListViewPresentor.lua

module("logic.extensions.commontabrank.view.goddesscompetition.GoddessCompetitionRankFatherListViewPresentor", package.seeall)

local GoddessCompetitionRankFatherListViewPresentor = class("GoddessCompetitionRankFatherListViewPresentor", ViewPresentor)

function GoddessCompetitionRankFatherListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRankFatherListViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/goddesscompetitionrankfatherlistview.prefab"
	}
end

function GoddessCompetitionRankFatherListViewPresentor:buildViews()
	return {
		GoddessCompetitionRankFatherListView.New()
	}
end

return GoddessCompetitionRankFatherListViewPresentor
