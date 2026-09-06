-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiMainViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiMainViewPresentor", package.seeall)

local TongLinShiJiMainViewPresentor = class("TongLinShiJiMainViewPresentor", ViewPresentor)

function TongLinShiJiMainViewPresentor:ctor()
	TongLinShiJiMainViewPresentor.super.ctor(self)
end

function TongLinShiJiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijimainview.prefab"
	}
end

function TongLinShiJiMainViewPresentor:buildViews()
	return {
		TongLinShiJiMainView.New()
	}
end

return TongLinShiJiMainViewPresentor
