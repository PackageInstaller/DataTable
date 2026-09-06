-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/view/CollectingraceViewPresentor.lua

module("logic.extensions.collectingrace.view.CollectingraceViewPresentor", package.seeall)

local CollectingraceViewPresentor = class("CollectingraceViewPresentor", ViewPresentor)

function CollectingraceViewPresentor:ctor()
	CollectingraceViewPresentor.super.ctor(self)
end

function CollectingraceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingraceViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingrace/collectingraceview.prefab"
	}
end

function CollectingraceViewPresentor:buildViews()
	return {
		CollectingRaceView.New()
	}
end

return CollectingraceViewPresentor
