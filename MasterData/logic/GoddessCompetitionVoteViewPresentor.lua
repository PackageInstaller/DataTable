-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionVoteViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionVoteViewPresentor", package.seeall)

local GoddessCompetitionVoteViewPresentor = class("GoddessCompetitionVoteViewPresentor", ViewPresentor)

function GoddessCompetitionVoteViewPresentor:ctor()
	GoddessCompetitionVoteViewPresentor.super.ctor(self)
end

function GoddessCompetitionVoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitionVoteViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitionvoteview.prefab"
	}
end

function GoddessCompetitionVoteViewPresentor:buildViews()
	return {
		GoddessCompetitionVoteView.New()
	}
end

return GoddessCompetitionVoteViewPresentor
