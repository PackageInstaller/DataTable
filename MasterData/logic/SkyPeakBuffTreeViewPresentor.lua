-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakBuffTreeViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakBuffTreeViewPresentor", package.seeall)

local SkyPeakBuffTreeViewPresentor = class("SkyPeakBuffTreeViewPresentor", ViewPresentor)

function SkyPeakBuffTreeViewPresentor:ctor()
	SkyPeakBuffTreeViewPresentor.super.ctor(self)
end

function SkyPeakBuffTreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakBuffTreeViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakbufftreeview.prefab"
	}
end

function SkyPeakBuffTreeViewPresentor:buildViews()
	return {
		SkyPeakBuffTreeView.New()
	}
end

return SkyPeakBuffTreeViewPresentor
