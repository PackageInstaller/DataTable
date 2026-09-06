-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtPassViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtPassViewPresentor", package.seeall)

local TongLinShiJiExtPassViewPresentor = class("TongLinShiJiExtPassViewPresentor", ViewPresentor)

function TongLinShiJiExtPassViewPresentor:ctor()
	TongLinShiJiExtPassViewPresentor.super.ctor(self)
end

function TongLinShiJiExtPassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiExtPassViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijiextpassview.prefab"
	}
end

function TongLinShiJiExtPassViewPresentor:buildViews()
	return {
		TongLinShiJiExtPassView.New()
	}
end

return TongLinShiJiExtPassViewPresentor
