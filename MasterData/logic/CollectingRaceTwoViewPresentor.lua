-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/view/CollectingRaceTwoViewPresentor.lua

module("logic.extensions.collectingrace.view.CollectingRaceTwoViewPresentor", package.seeall)

local CollectingRaceTwoViewPresentor = class("CollectingRaceTwoViewPresentor", ViewPresentor)

function CollectingRaceTwoViewPresentor:ctor()
	CollectingRaceTwoViewPresentor.super.ctor(self)
end

function CollectingRaceTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectingRaceTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/collectingrace/collectingracetwoview.prefab"
	}
end

function CollectingRaceTwoViewPresentor:buildViews()
	return {
		CollectingRaceTwoView.New()
	}
end

return CollectingRaceTwoViewPresentor
