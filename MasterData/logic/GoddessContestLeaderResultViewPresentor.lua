-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestLeaderResultViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestLeaderResultViewPresentor", package.seeall)

local GoddessContestLeaderResultViewPresentor = class("GoddessContestLeaderResultViewPresentor", ViewPresentor)

function GoddessContestLeaderResultViewPresentor:ctor()
	GoddessContestLeaderResultViewPresentor.super.ctor(self)
end

function GoddessContestLeaderResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestLeaderResultViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestleaderresultview.prefab"
	}
end

function GoddessContestLeaderResultViewPresentor:buildViews()
	return {
		GoddessContestLeaderResultView.New()
	}
end

return GoddessContestLeaderResultViewPresentor
