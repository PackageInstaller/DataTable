-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiNorBossViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiNorBossViewPresentor", package.seeall)

local TongLinShiJiNorBossViewPresentor = class("TongLinShiJiNorBossViewPresentor", ViewPresentor)

function TongLinShiJiNorBossViewPresentor:ctor()
	TongLinShiJiNorBossViewPresentor.super.ctor(self)
end

function TongLinShiJiNorBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiNorBossViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijinorbossview.prefab"
	}
end

function TongLinShiJiNorBossViewPresentor:buildViews()
	return {
		TongLinShiJiNorBossView.New()
	}
end

return TongLinShiJiNorBossViewPresentor
