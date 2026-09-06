-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/RemotehierarchyViewPresentor.lua

module("logic.extensions.gm.view.RemotehierarchyViewPresentor", package.seeall)

local RemotehierarchyViewPresentor = class("RemotehierarchyViewPresentor", ViewPresentor)

function RemotehierarchyViewPresentor:ctor()
	RemotehierarchyViewPresentor.super.ctor(self)
end

function RemotehierarchyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RemotehierarchyViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/remotehierarchyview.prefab"
	}
end

function RemotehierarchyViewPresentor:buildViews()
	return {
		RemotehierarchyView.New()
	}
end

return RemotehierarchyViewPresentor
