-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionWeekRankViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionWeekRankViewPresentor", package.seeall)

local GoddessCompetitionWeekRankViewPresentor = class("GoddessCompetitionWeekRankViewPresentor", ViewPresentor)

function GoddessCompetitionWeekRankViewPresentor:ctor()
	GoddessCompetitionWeekRankViewPresentor.super.ctor(self)
end

function GoddessCompetitionWeekRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionWeekRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionweekrankview.prefab"
	}
end

function GoddessCompetitionWeekRankViewPresentor:buildViews()
	return {
		GoddessCompetitionWeekRankView.New()
	}
end

function GoddessCompetitionWeekRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionWeekRankViewPresentor
