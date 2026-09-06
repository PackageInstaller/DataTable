-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanMainViewPresentor.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanMainViewPresentor", package.seeall)

local DivineKingCiYuanMainViewPresentor = class("DivineKingCiYuanMainViewPresentor", ViewPresentor)

function DivineKingCiYuanMainViewPresentor:ctor()
	DivineKingCiYuanMainViewPresentor.super.ctor(self)
end

function DivineKingCiYuanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingCiYuanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingciyuan/divinekingciyuanmainview.prefab"
	}
end

function DivineKingCiYuanMainViewPresentor:buildViews()
	return {
		DivineKingCiYuanMainView.New()
	}
end

return DivineKingCiYuanMainViewPresentor
