-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GrouprechargerankViewPresentor.lua

module("logic.extensions.grouprecharge.view.GrouprechargerankViewPresentor", package.seeall)

local GrouprechargerankViewPresentor = class("GrouprechargerankViewPresentor", ViewPresentor)

function GrouprechargerankViewPresentor:ctor()
	GrouprechargerankViewPresentor.super.ctor(self)
end

function GrouprechargerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GrouprechargerankViewPresentor:dependWhatResources()
	return {
		"ui/views/grouprecharge/grouprechargerankview.prefab"
	}
end

function GrouprechargerankViewPresentor:buildViews()
	return {
		GroupRechargeRankView.New()
	}
end

return GrouprechargerankViewPresentor
