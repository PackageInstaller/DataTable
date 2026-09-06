-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/view/RepairChannelDetailViewPresentor.lua

module("logic.extensions.repairchannel.view.RepairChannelDetailViewPresentor", package.seeall)

local RepairChannelDetailViewPresentor = class("RepairChannelDetailViewPresentor", ViewPresentor)

function RepairChannelDetailViewPresentor:ctor()
	RepairChannelDetailViewPresentor.super.ctor(self)
end

function RepairChannelDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RepairChannelDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/repairchannel/repairchanneldetailview.prefab"
	}
end

function RepairChannelDetailViewPresentor:buildViews()
	return {
		RepairChannelDetailView.New()
	}
end

return RepairChannelDetailViewPresentor
