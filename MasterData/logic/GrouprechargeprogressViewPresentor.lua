-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GrouprechargeprogressViewPresentor.lua

module("logic.extensions.grouprecharge.view.GrouprechargeprogressViewPresentor", package.seeall)

local GrouprechargeprogressViewPresentor = class("GrouprechargeprogressViewPresentor", ViewPresentor)

function GrouprechargeprogressViewPresentor:ctor()
	GrouprechargeprogressViewPresentor.super.ctor(self)
end

function GrouprechargeprogressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GrouprechargeprogressViewPresentor:dependWhatResources()
	return {
		"ui/views/grouprecharge/grouprechargeprogressview.prefab"
	}
end

function GrouprechargeprogressViewPresentor:buildViews()
	return {
		GroupRechargeProgressView.New()
	}
end

return GrouprechargeprogressViewPresentor
