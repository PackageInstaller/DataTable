-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjimixcollectViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjimixcollectViewPresentor", package.seeall)

local KingjimixcollectViewPresentor = class("KingjimixcollectViewPresentor", ViewPresentor)

function KingjimixcollectViewPresentor:ctor()
	KingjimixcollectViewPresentor.super.ctor(self)
end

function KingjimixcollectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingjimixcollectViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjimixcollectview.prefab"
	}
end

function KingjimixcollectViewPresentor:buildViews()
	return {
		KingjimixcollectView.New()
	}
end

return KingjimixcollectViewPresentor
