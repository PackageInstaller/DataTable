-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtFinishViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtFinishViewPresentor", package.seeall)

local TongLinShiJiExtFinishViewPresentor = class("TongLinShiJiExtFinishViewPresentor", ViewPresentor)

function TongLinShiJiExtFinishViewPresentor:ctor()
	TongLinShiJiExtFinishViewPresentor.super.ctor(self)
end

function TongLinShiJiExtFinishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiExtFinishViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijiextfinishview.prefab"
	}
end

function TongLinShiJiExtFinishViewPresentor:buildViews()
	return {
		TongLinShiJiExtFinishView.New()
	}
end

return TongLinShiJiExtFinishViewPresentor
