-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupredpackselectViewPresentor.lua

module("logic.extensions.groupredpack.view.GroupredpackselectViewPresentor", package.seeall)

local GroupredpackselectViewPresentor = class("GroupredpackselectViewPresentor", ViewPresentor)

function GroupredpackselectViewPresentor:ctor()
	GroupredpackselectViewPresentor.super.ctor(self)
end

function GroupredpackselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupredpackselectViewPresentor:dependWhatResources()
	return {
		"ui/views/groupredpack/groupredpackselectview.prefab"
	}
end

function GroupredpackselectViewPresentor:buildViews()
	return {
		GroupRedpackSelectView.New()
	}
end

return GroupredpackselectViewPresentor
