-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GrouprechargemainViewPresentor.lua

module("logic.extensions.grouprecharge.view.GrouprechargemainViewPresentor", package.seeall)

local GrouprechargemainViewPresentor = class("GrouprechargemainViewPresentor", ViewPresentor)

function GrouprechargemainViewPresentor:ctor()
	GrouprechargemainViewPresentor.super.ctor(self)
end

function GrouprechargemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GrouprechargemainViewPresentor:dependWhatResources()
	return {
		"ui/views/grouprecharge/grouprechargemainview.prefab"
	}
end

function GrouprechargemainViewPresentor:buildViews()
	return {
		GroupRechargeMainView.New()
	}
end

return GrouprechargemainViewPresentor
