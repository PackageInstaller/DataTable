-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/goddesscompetition/GoddessCompetitionActivityChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.goddesscompetition.GoddessCompetitionActivityChildRankViewPresentor", package.seeall)

local GoddessCompetitionActivityChildRankViewPresentor = class("GoddessCompetitionActivityChildRankViewPresentor", ViewPresentor)

function GoddessCompetitionActivityChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionActivityChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/goddesscompetitionactivitychildrankview.prefab"
	}
end

function GoddessCompetitionActivityChildRankViewPresentor:buildViews()
	return {
		GoddessCompetitionActivityChildRankView.New()
	}
end

function GoddessCompetitionActivityChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionActivityChildRankViewPresentor
