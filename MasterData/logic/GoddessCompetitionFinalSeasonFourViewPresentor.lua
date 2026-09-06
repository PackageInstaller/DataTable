-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFinalSeasonFourViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFinalSeasonFourViewPresentor", package.seeall)

local GoddessCompetitionFinalSeasonFourViewPresentor = class("GoddessCompetitionFinalSeasonFourViewPresentor", ViewPresentor)

function GoddessCompetitionFinalSeasonFourViewPresentor:ctor()
	GoddessCompetitionFinalSeasonFourViewPresentor.super.ctor(self)
end

function GoddessCompetitionFinalSeasonFourViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionFinalSeasonFourViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionfinalseasonfourview.prefab"
	}
end

function GoddessCompetitionFinalSeasonFourViewPresentor:buildViews()
	return {
		GoddessCompetitionFinalSeasonFourView.New()
	}
end

function GoddessCompetitionFinalSeasonFourViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionFinalSeasonFourViewPresentor
