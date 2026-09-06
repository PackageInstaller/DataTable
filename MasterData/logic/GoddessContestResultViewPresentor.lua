-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestResultViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestResultViewPresentor", package.seeall)

local GoddessContestResultViewPresentor = class("GoddessContestResultViewPresentor", ViewPresentor)

function GoddessContestResultViewPresentor:ctor()
	GoddessContestResultViewPresentor.super.ctor(self)
end

function GoddessContestResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestResultViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestresultview.prefab"
	}
end

function GoddessContestResultViewPresentor:buildViews()
	return {
		GoddessContestResultView.New()
	}
end

return GoddessContestResultViewPresentor
