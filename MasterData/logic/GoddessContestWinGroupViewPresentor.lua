-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestWinGroupViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestWinGroupViewPresentor", package.seeall)

local GoddessContestWinGroupViewPresentor = class("GoddessContestWinGroupViewPresentor", ViewPresentor)

function GoddessContestWinGroupViewPresentor:ctor()
	GoddessContestWinGroupViewPresentor.super.ctor(self)
end

function GoddessContestWinGroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestWinGroupViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestwingroupview.prefab"
	}
end

function GoddessContestWinGroupViewPresentor:buildViews()
	return {
		GoddessContestWinGroupView.New()
	}
end

return GoddessContestWinGroupViewPresentor
