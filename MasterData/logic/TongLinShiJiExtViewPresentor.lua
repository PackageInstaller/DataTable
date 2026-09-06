-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtViewPresentor", package.seeall)

local TongLinShiJiExtViewPresentor = class("TongLinShiJiExtViewPresentor", ViewPresentor)

function TongLinShiJiExtViewPresentor:ctor()
	TongLinShiJiExtViewPresentor.super.ctor(self)
end

function TongLinShiJiExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiExtViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijiextview.prefab"
	}
end

function TongLinShiJiExtViewPresentor:buildViews()
	return {
		TongLinShiJiExtView.New()
	}
end

return TongLinShiJiExtViewPresentor
