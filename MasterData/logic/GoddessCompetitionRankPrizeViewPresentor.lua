-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRankPrizeViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRankPrizeViewPresentor", package.seeall)

local GoddessCompetitionRankPrizeViewPresentor = class("GoddessCompetitionRankPrizeViewPresentor", ViewPresentor)

function GoddessCompetitionRankPrizeViewPresentor:ctor()
	GoddessCompetitionRankPrizeViewPresentor.super.ctor(self)
end

function GoddessCompetitionRankPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRankPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionrankprizeview.prefab"
	}
end

function GoddessCompetitionRankPrizeViewPresentor:buildViews()
	return {
		GoddessCompetitionRankPrizeView.New()
	}
end

function GoddessCompetitionRankPrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionRankPrizeViewPresentor
