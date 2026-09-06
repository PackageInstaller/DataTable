-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjisoulsmallViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjisoulsmallViewPresentor", package.seeall)

local KingjisoulsmallViewPresentor = class("KingjisoulsmallViewPresentor", ViewPresentor)

function KingjisoulsmallViewPresentor:ctor()
	KingjisoulsmallViewPresentor.super.ctor(self)
end

function KingjisoulsmallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingjisoulsmallViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjisoulsmallview.prefab"
	}
end

function KingjisoulsmallViewPresentor:buildViews()
	return {
		KingjisoulsmallView.New()
	}
end

return KingjisoulsmallViewPresentor
