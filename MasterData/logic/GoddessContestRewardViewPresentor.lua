-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestRewardViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestRewardViewPresentor", package.seeall)

local GoddessContestRewardViewPresentor = class("GoddessContestRewardViewPresentor", ViewPresentor)

function GoddessContestRewardViewPresentor:ctor()
	GoddessContestRewardViewPresentor.super.ctor(self)
end

function GoddessContestRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestrewardview.prefab"
	}
end

function GoddessContestRewardViewPresentor:buildViews()
	return {
		GoddessContestRewardView.New()
	}
end

return GoddessContestRewardViewPresentor
