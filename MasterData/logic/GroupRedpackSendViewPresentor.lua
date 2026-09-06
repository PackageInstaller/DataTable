-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackSendViewPresentor.lua

module("logic.extensions.groupredpack.view.GroupRedpackSendViewPresentor", package.seeall)

local GroupRedpackSendViewPresentor = class("GroupRedpackSendViewPresentor", ViewPresentor)

function GroupRedpackSendViewPresentor:ctor()
	GroupRedpackSendViewPresentor.super.ctor(self)
end

function GroupRedpackSendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupRedpackSendViewPresentor:dependWhatResources()
	return {
		"ui/views/groupredpack/groupredpacksendview.prefab"
	}
end

function GroupRedpackSendViewPresentor:buildViews()
	return {
		GroupRedpackSendView.New()
	}
end

return GroupRedpackSendViewPresentor
