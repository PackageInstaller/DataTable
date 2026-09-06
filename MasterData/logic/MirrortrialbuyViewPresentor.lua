-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialbuyViewPresentor.lua

module("logic.extensions.mirrortrial.view.MirrortrialbuyViewPresentor", package.seeall)

local MirrortrialbuyViewPresentor = class("MirrortrialbuyViewPresentor", ViewPresentor)

function MirrortrialbuyViewPresentor:ctor()
	MirrortrialbuyViewPresentor.super.ctor(self)
end

function MirrortrialbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function MirrortrialbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/mirrortrial/mirrortrialbuyview.prefab"
	}
end

function MirrortrialbuyViewPresentor:buildViews()
	return {
		MirrortrialbuyView.New()
	}
end

return MirrortrialbuyViewPresentor
