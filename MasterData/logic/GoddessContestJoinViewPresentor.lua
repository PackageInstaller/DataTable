-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestJoinViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestJoinViewPresentor", package.seeall)

local GoddessContestJoinViewPresentor = class("GoddessContestJoinViewPresentor", ViewPresentor)

function GoddessContestJoinViewPresentor:ctor()
	GoddessContestJoinViewPresentor.super.ctor(self)
end

function GoddessContestJoinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestJoinViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestjoinview.prefab"
	}
end

function GoddessContestJoinViewPresentor:buildViews()
	return {
		GoddessContestJoinView.New()
	}
end

return GoddessContestJoinViewPresentor
