-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rotationlist/RotationListViewPresentor.lua

module("logic.extensions.rotationlist.RotationListViewPresentor", package.seeall)

local RotationListViewPresentor = class("RotationListViewPresentor", ViewPresentor)

function RotationListViewPresentor:ctor()
	RotationListViewPresentor.super.ctor(self)
end

function RotationListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RotationListViewPresentor:dependWhatResources()
	return {
		"ui/views/rotationlist/rotationlistview.prefab"
	}
end

function RotationListViewPresentor:buildViews()
	return {
		RotationListView.New()
	}
end

return RotationListViewPresentor
