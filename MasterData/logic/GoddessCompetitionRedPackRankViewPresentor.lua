-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedPackRankViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedPackRankViewPresentor", package.seeall)

local GoddessCompetitionRedPackRankViewPresentor = class("GoddessCompetitionRedPackRankViewPresentor", ViewPresentor)

function GoddessCompetitionRedPackRankViewPresentor:ctor()
	GoddessCompetitionRedPackRankViewPresentor.super.ctor(self)
end

function GoddessCompetitionRedPackRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionRedPackRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionredpackrankview.prefab"
	}
end

function GoddessCompetitionRedPackRankViewPresentor:buildViews()
	return {
		GoddessCompetitionRedPackRankView.New()
	}
end

function GoddessCompetitionRedPackRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitionRedPackRankViewPresentor
