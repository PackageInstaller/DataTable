-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjimixViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjimixViewPresentor", package.seeall)

local KingjimixViewPresentor = class("KingjimixViewPresentor", ViewPresentor)

function KingjimixViewPresentor:ctor()
	KingjimixViewPresentor.super.ctor(self)
end

function KingjimixViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingjimixViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjimixview.prefab"
	}
end

function KingjimixViewPresentor:buildViews()
	return {
		KingjimixView.New()
	}
end

return KingjimixViewPresentor
