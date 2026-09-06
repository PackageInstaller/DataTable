-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoLunHuaViewPresentor.lua

module("logic.extensions.liudao.view.LiuDaoLunHuaViewPresentor", package.seeall)

local LiuDaoLunHuaViewPresentor = class("LiuDaoLunHuaViewPresentor", ViewPresentor)

function LiuDaoLunHuaViewPresentor:ctor()
	LiuDaoLunHuaViewPresentor.super.ctor(self)
end

function LiuDaoLunHuaViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LiuDaoLunHuaViewPresentor:dependWhatResources()
	return {
		"ui/views/liudao/liudaolunhuaview.prefab"
	}
end

function LiuDaoLunHuaViewPresentor:buildViews()
	return {
		LiuDaoLunHuaView.New()
	}
end

return LiuDaoLunHuaViewPresentor
