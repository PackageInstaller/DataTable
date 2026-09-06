-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGroupMemberViewPresentor.lua

module("logic.extensions.goddesscontest.view.GoddessContestGroupMemberViewPresentor", package.seeall)

local GoddessContestGroupMemberViewPresentor = class("GoddessContestGroupMemberViewPresentor", ViewPresentor)

function GoddessContestGroupMemberViewPresentor:ctor()
	GoddessContestGroupMemberViewPresentor.super.ctor(self)
end

function GoddessContestGroupMemberViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessContestGroupMemberViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/goddesscontestgroupmemberview.prefab"
	}
end

function GoddessContestGroupMemberViewPresentor:buildViews()
	return {
		GoddessContestGroupMemberView.New()
	}
end

return GoddessContestGroupMemberViewPresentor
