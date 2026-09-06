-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoMainViewPresentor.lua

module("logic.extensions.liudao.view.LiuDaoMainViewPresentor", package.seeall)

local LiuDaoMainViewPresentor = class("LiuDaoMainViewPresentor", ViewPresentor)

function LiuDaoMainViewPresentor:ctor()
	LiuDaoMainViewPresentor.super.ctor(self)
end

function LiuDaoMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiuDaoMainViewPresentor:dependWhatResources()
	return {
		"ui/views/liudao/liudaomainview.prefab"
	}
end

function LiuDaoMainViewPresentor:buildViews()
	return {
		LiuDaoMainView.New()
	}
end

return LiuDaoMainViewPresentor
