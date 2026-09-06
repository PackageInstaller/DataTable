-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GrouprechargematchViewPresentor.lua

module("logic.extensions.grouprecharge.view.GrouprechargematchViewPresentor", package.seeall)

local GrouprechargematchViewPresentor = class("GrouprechargematchViewPresentor", ViewPresentor)

function GrouprechargematchViewPresentor:ctor()
	GrouprechargematchViewPresentor.super.ctor(self)
end

function GrouprechargematchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GrouprechargematchViewPresentor:dependWhatResources()
	return {
		"ui/views/grouprecharge/grouprechargematchview.prefab"
	}
end

function GrouprechargematchViewPresentor:buildViews()
	return {
		GroupRechargeMatchView.New()
	}
end

return GrouprechargematchViewPresentor
