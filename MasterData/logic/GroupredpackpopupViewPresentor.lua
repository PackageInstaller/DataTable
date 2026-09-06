-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupredpackpopupViewPresentor.lua

module("logic.extensions.groupredpack.view.GroupredpackpopupViewPresentor", package.seeall)

local GroupredpackpopupViewPresentor = class("GroupredpackpopupViewPresentor", ViewPresentor)

function GroupredpackpopupViewPresentor:ctor()
	GroupredpackpopupViewPresentor.super.ctor(self)
end

function GroupredpackpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupredpackpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/groupredpack/groupredpackpopupview.prefab"
	}
end

function GroupredpackpopupViewPresentor:buildViews()
	return {
		GroupRedpackPopupView.New()
	}
end

return GroupredpackpopupViewPresentor
