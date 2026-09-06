-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFansRankViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFansRankViewPresentor", package.seeall)

local GoddessCompetitionFansRankViewPresentor = class("GoddessCompetitionFansRankViewPresentor", ViewPresentor)

function GoddessCompetitionFansRankViewPresentor:ctor()
	GoddessCompetitionFansRankViewPresentor.super.ctor(self)
end

function GoddessCompetitionFansRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionFansRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionfansrankview.prefab"
	}
end

function GoddessCompetitionFansRankViewPresentor:buildViews()
	return {
		GoddessCompetitionFansRankView.New()
	}
end

function GoddessCompetitionFansRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionFansRankViewPresentor
