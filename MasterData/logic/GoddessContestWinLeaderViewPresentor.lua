-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestWinLeaderViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestWinLeaderViewPresentor", package.seeall)

local GoddessContestWinLeaderViewPresentor = class("GoddessContestWinLeaderViewPresentor", ViewPresentor)

function GoddessContestWinLeaderViewPresentor:ctor()
	GoddessContestWinLeaderViewPresentor.super.ctor(self)
end

function GoddessContestWinLeaderViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestWinLeaderViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestwinleaderview.prefab"
	}
end

function GoddessContestWinLeaderViewPresentor:buildViews()
	return {
		GoddessContestWinLeaderView.New()
	}
end

return GoddessContestWinLeaderViewPresentor
