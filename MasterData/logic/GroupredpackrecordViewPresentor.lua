-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupredpackrecordViewPresentor.lua

module("logic.extensions.groupredpack.view.GroupredpackrecordViewPresentor", package.seeall)

local GroupredpackrecordViewPresentor = class("GroupredpackrecordViewPresentor", ViewPresentor)

function GroupredpackrecordViewPresentor:ctor()
	GroupredpackrecordViewPresentor.super.ctor(self)
end

function GroupredpackrecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GroupredpackrecordViewPresentor:dependWhatResources()
	return {
		"ui/views/groupredpack/groupredpackrecordview.prefab"
	}
end

function GroupredpackrecordViewPresentor:buildViews()
	return {
		GroupRedpackRecordView.New()
	}
end

return GroupredpackrecordViewPresentor
