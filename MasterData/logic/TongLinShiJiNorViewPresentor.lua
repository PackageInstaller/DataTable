-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiNorViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiNorViewPresentor", package.seeall)

local TongLinShiJiNorViewPresentor = class("TongLinShiJiNorViewPresentor", ViewPresentor)

function TongLinShiJiNorViewPresentor:ctor()
	TongLinShiJiNorViewPresentor.super.ctor(self)
end

function TongLinShiJiNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiNorViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijinorview.prefab"
	}
end

function TongLinShiJiNorViewPresentor:buildViews()
	return {
		TongLinShiJiNorView.New()
	}
end

return TongLinShiJiNorViewPresentor
