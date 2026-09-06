-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoYuanSuShiViewPresentor.lua

module("logic.extensions.liudao.view.LiuDaoYuanSuShiViewPresentor", package.seeall)

local LiuDaoYuanSuShiViewPresentor = class("LiuDaoYuanSuShiViewPresentor", ViewPresentor)

function LiuDaoYuanSuShiViewPresentor:ctor()
	LiuDaoYuanSuShiViewPresentor.super.ctor(self)
end

function LiuDaoYuanSuShiViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LiuDaoYuanSuShiViewPresentor:dependWhatResources()
	return {
		"ui/views/liudao/liudaoyuansushiview.prefab"
	}
end

function LiuDaoYuanSuShiViewPresentor:buildViews()
	return {
		LiuDaoYuanSuShiView.New()
	}
end

return LiuDaoYuanSuShiViewPresentor
