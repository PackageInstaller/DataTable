-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtCoverViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtCoverViewPresentor", package.seeall)

local TongLinShiJiExtCoverViewPresentor = class("TongLinShiJiExtCoverViewPresentor", ViewPresentor)

function TongLinShiJiExtCoverViewPresentor:ctor()
	TongLinShiJiExtCoverViewPresentor.super.ctor(self)
end

function TongLinShiJiExtCoverViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiExtCoverViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijiextcoverview.prefab"
	}
end

function TongLinShiJiExtCoverViewPresentor:buildViews()
	return {
		TongLinShiJiExtCoverView.New()
	}
end

return TongLinShiJiExtCoverViewPresentor
