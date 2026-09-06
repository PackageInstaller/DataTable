-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestWinnerViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestWinnerViewPresentor", package.seeall)

local GoddessContestWinnerViewPresentor = class("GoddessContestWinnerViewPresentor", ViewPresentor)

function GoddessContestWinnerViewPresentor:ctor()
	GoddessContestWinnerViewPresentor.super.ctor(self)
end

function GoddessContestWinnerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestWinnerViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestwinnerview.prefab"
	}
end

function GoddessContestWinnerViewPresentor:buildViews()
	return {
		GoddessContestWinnerView.New()
	}
end

return GoddessContestWinnerViewPresentor
