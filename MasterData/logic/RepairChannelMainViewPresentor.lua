-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/view/RepairChannelMainViewPresentor.lua

module("logic.extensions.repairchannel.view.RepairChannelMainViewPresentor", package.seeall)

local RepairChannelMainViewPresentor = class("RepairChannelMainViewPresentor", ViewPresentor)

function RepairChannelMainViewPresentor:ctor()
	RepairChannelMainViewPresentor.super.ctor(self)
end

function RepairChannelMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RepairChannelMainViewPresentor:dependWhatResources()
	return {
		"ui/views/repairchannel/repairchannelmainview.prefab"
	}
end

function RepairChannelMainViewPresentor:buildViews()
	return {
		RepairChannelMainView.New()
	}
end

return RepairChannelMainViewPresentor
