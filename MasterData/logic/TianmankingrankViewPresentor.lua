-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingrankViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmankingrankViewPresentor", package.seeall)

local TianmankingrankViewPresentor = class("TianmankingrankViewPresentor", ViewPresentor)

function TianmankingrankViewPresentor:ctor()
	TianmankingrankViewPresentor.super.ctor(self)
end

function TianmankingrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianmankingrankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingrankview.prefab"
	}
end

function TianmankingrankViewPresentor:buildViews()
	return {
		TianmankingrankView.New()
	}
end

return TianmankingrankViewPresentor
