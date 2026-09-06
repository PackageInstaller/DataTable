-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackGrabViewPresentor.lua

module("logic.extensions.groupredpack.view.GroupRedpackGrabViewPresentor", package.seeall)

local GroupRedpackGrabViewPresentor = class("GroupRedpackGrabViewPresentor", ViewPresentor)

function GroupRedpackGrabViewPresentor:ctor()
	GroupRedpackGrabViewPresentor.super.ctor(self)
end

function GroupRedpackGrabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRedpackGrabViewPresentor:dependWhatResources()
	return {
		"ui/views/groupredpack/groupredpackgrabview.prefab"
	}
end

function GroupRedpackGrabViewPresentor:buildViews()
	return {
		GroupRedpackGrabView.New()
	}
end

return GroupRedpackGrabViewPresentor
