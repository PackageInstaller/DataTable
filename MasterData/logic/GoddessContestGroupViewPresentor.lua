-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGroupViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestGroupViewPresentor", package.seeall)

local GoddessContestGroupViewPresentor = class("GoddessContestGroupViewPresentor", ViewPresentor)

function GoddessContestGroupViewPresentor:ctor()
	GoddessContestGroupViewPresentor.super.ctor(self)
end

function GoddessContestGroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestGroupViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestgroupview.prefab"
	}
end

function GoddessContestGroupViewPresentor:buildViews()
	return {
		GoddessContestGroupView.New()
	}
end

function GoddessContestGroupViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessContestGroupViewPresentor
