-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtStageViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtStageViewPresentor", package.seeall)

local TongLinShiJiExtStageViewPresentor = class("TongLinShiJiExtStageViewPresentor", ViewPresentor)

function TongLinShiJiExtStageViewPresentor:ctor()
	TongLinShiJiExtStageViewPresentor.super.ctor(self)
end

function TongLinShiJiExtStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiExtStageViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijiextstageview.prefab"
	}
end

function TongLinShiJiExtStageViewPresentor:buildViews()
	return {
		TongLinShiJiExtStageView.New()
	}
end

return TongLinShiJiExtStageViewPresentor
