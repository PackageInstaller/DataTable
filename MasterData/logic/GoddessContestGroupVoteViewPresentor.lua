-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGroupVoteViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestGroupVoteViewPresentor", package.seeall)

local GoddessContestGroupVoteViewPresentor = class("GoddessContestGroupVoteViewPresentor", ViewPresentor)

function GoddessContestGroupVoteViewPresentor:ctor()
	GoddessContestGroupVoteViewPresentor.super.ctor(self)
end

function GoddessContestGroupVoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestGroupVoteViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestgroupvoteview.prefab"
	}
end

function GoddessContestGroupVoteViewPresentor:buildViews()
	return {
		GoddessContestGroupVoteView.New()
	}
end

return GoddessContestGroupVoteViewPresentor
