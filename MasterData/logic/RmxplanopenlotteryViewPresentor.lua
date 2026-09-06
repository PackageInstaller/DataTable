-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanopenlotteryViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanopenlotteryViewPresentor", package.seeall)

local RmxplanopenlotteryViewPresentor = class("RmxplanopenlotteryViewPresentor", ViewPresentor)

function RmxplanopenlotteryViewPresentor:ctor()
	RmxplanopenlotteryViewPresentor.super.ctor(self)
end

function RmxplanopenlotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanopenlotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanopenlotteryview.prefab"
	}
end

function RmxplanopenlotteryViewPresentor:buildViews()
	return {
		RmxplanopenlotteryView.New()
	}
end

return RmxplanopenlotteryViewPresentor
