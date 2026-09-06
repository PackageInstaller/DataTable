-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/goddesscompetition/GoddessCompetitionRedPackChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.goddesscompetition.GoddessCompetitionRedPackChildRankViewPresentor", package.seeall)

local GoddessCompetitionRedPackChildRankViewPresentor = class("GoddessCompetitionRedPackChildRankViewPresentor", ViewPresentor)

function GoddessCompetitionRedPackChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRedPackChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/goddesscompetitionredpackchildrankview.prefab"
	}
end

function GoddessCompetitionRedPackChildRankViewPresentor:buildViews()
	return {
		GoddessCompetitionRedPackChildRankView.New()
	}
end

function GoddessCompetitionRedPackChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionRedPackChildRankViewPresentor
