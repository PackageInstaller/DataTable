-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/goddesscompetition/GoddessCompetitionStepChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.goddesscompetition.GoddessCompetitionStepChildRankViewPresentor", package.seeall)

local GoddessCompetitionStepChildRankViewPresentor = class("GoddessCompetitionStepChildRankViewPresentor", ViewPresentor)

function GoddessCompetitionStepChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionStepChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/goddesscompetitionstepchildrankview.prefab"
	}
end

function GoddessCompetitionStepChildRankViewPresentor:buildViews()
	return {
		GoddessCompetitionStepChildRankView.New()
	}
end

function GoddessCompetitionStepChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionStepChildRankViewPresentor
